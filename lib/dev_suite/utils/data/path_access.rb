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

        private

        # Parse the path into an array of keys/symbols/integers
        def parse_path(path)
          # If path is already an array, return it
          return path if path.is_a?(Array)

          # If path is a symbol without dots, return it as a single-element array
          return [path] if path.is_a?(Symbol) && !path.to_s.include?(".")

          # Handle symbols like :"test.1" by splitting on the dot
          if path.is_a?(Symbol) && path.to_s.include?(".")
            return path.to_s.split(".").map { |part| part.match?(/^\d+$/) ? part.to_i : part.to_sym }
          end

          # Handle string paths like 'users.1.name'
          path.to_s.split(/\.|\[|\]/).reject(&:empty?).map do |part|
            part.match?(/^\d+$/) ? part.to_i : part.to_sym
          end
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
              current_data[key.to_sym] ||= {}
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
            target[last_key.to_sym] = value
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
      end
    end
  end
end
