# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module PathAccess
        # Fetch value from a nested structure using a path
        def get_value_by_path(data, path)
          keys = parse_path(path)
          traverse_path_for_get(data, keys)
        end

        # Set value in a nested structure using a path
        def set_value_by_path(data, path, value)
          keys = parse_path(path)
          last_key = keys.pop
          target = traverse_path_for_set(data, keys)

          set_final_value(target, last_key, value)
        end

        # Delete a key from a nested structure using a path
        def delete_key_by_path(data, path)
          keys = parse_path(path)
          last_key = keys.pop
          target = traverse_path_for_delete(data, keys)

          delete_final_key(target, last_key)
        end

        private

        # Parse the path into an array of keys/symbols/integers
        def parse_path(path)
          return path if path.is_a?(Array)
          return [path] if single_symbol_path?(path)

          parse_symbol_or_string_path(path)
        end

        # Check if the path is a symbol without dots
        def single_symbol_path?(path)
          path.is_a?(Symbol) && !path.to_s.include?(".")
        end

        # Parse a symbol or string path into an array of keys
        def parse_symbol_or_string_path(path)
          if path.is_a?(Symbol)
            parse_symbol_path(path)
          else
            parse_string_path(path)
          end
        end

        # Parse a symbol path that contains dots (e.g., :"test.1")
        def parse_symbol_path(path)
          path.to_s.split(".").map { |part| parse_part(part) }
        end

        # Parse a string path into keys (e.g., 'users.1.name')
        def parse_string_path(path)
          path.to_s.split(/\.|\[|\]/).reject(&:empty?).map { |part| parse_part(part) }
        end

        # Parse each part into either a symbol or integer
        def parse_part(part)
          part.match?(/^\d+$/) ? part.to_i : part.to_sym
        end

        # Helper to traverse the path for getting values
        def traverse_path_for_get(data, keys)
          keys.reduce(data) do |current_data, key|
            check_invalid_path(current_data, key)

            case current_data
            when Hash
              fetch_from_hash(current_data, key)
            when Array
              fetch_from_array(current_data, key)
            else
              raise KeyError, "Invalid data type at '#{key}'"
            end
          end
        end

        # Helper to traverse the path for setting values
        def traverse_path_for_set(data, keys)
          keys.reduce(data) do |current_data, key|
            check_invalid_path(current_data, key)

            case current_data
            when Hash
              current_data[find_existing_key(current_data, key)] ||= {}
            when Array
              current_data[key.to_i] ||= {}
            else
              break nil
            end
          end
        end

        # Helper to check for invalid paths
        def check_invalid_path(data, key)
          raise KeyError, "Invalid path at '#{key}'" if data.nil?
        end

        # Fetch value from a hash, trying both symbol and string keys
        def fetch_from_hash(hash, key)
          hash[key.to_sym] || hash[key.to_s]
        end

        # Fetch value from an array if the key is an integer
        def fetch_from_array(array, key)
          key.is_a?(Integer) ? array[key] : nil
        end

        # Set the final value in a hash or array
        def set_final_value(target, last_key, value)
          case target
          when Hash
            target[find_existing_key(target, last_key)] = value
          when Array
            if last_key.is_a?(Integer)
              target[last_key] = value
            else
              raise KeyError, "Invalid path or type at '#{last_key}'"
            end
          else
            raise KeyError, "Invalid target type for path at '#{last_key}'"
          end
        end

        # Check if the key already exists and return the key in its original type (symbol or string)
        def find_existing_key(hash, key)
          return key if hash.key?(key) # Key already exists in original form
          return key.to_s if hash.key?(key.to_s) # Exists as a string
          return key.to_sym if hash.key?(key.to_sym) # Exists as a symbol

          key # Otherwise, return the key as-is (use the incoming type)
        end

        # Helper to traverse the path for deletion
        def traverse_path_for_delete(data, keys)
          keys.reduce(data) do |current_data, key|
            check_invalid_path(current_data, key)

            case current_data
            when Hash
              current_data[find_existing_key(current_data, key)]
            when Array
              current_data[key.to_i]
            else
              raise KeyError, "Invalid data type at '#{key}'"
            end
          end
        end

        # Helper to delete the final key in a hash or array
        def delete_final_key(target, last_key)
          case target
          when Hash
            target.delete(find_existing_key(target, last_key))
          when Array
            target.delete_at(last_key.to_i) if last_key.is_a?(Integer)
          else
            raise KeyError, "Cannot delete key from unsupported data type"
          end
        end
      end
    end
  end
end
