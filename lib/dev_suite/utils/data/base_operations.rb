# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module BaseOperations
        # Recursively delete a key from any level in the data structure
        def deep_delete_key(data, key_to_delete)
          case data
          when Hash
            delete_key_from_hash(data, key_to_delete)
          when Array
            delete_key_from_array(data, key_to_delete)
          else
            data
          end
        end

        # Deep merge two hashes, including nested keys
        def deep_merge(hash1, hash2)
          hash1.merge(hash2) do |_key, old_val, new_val|
            if old_val.is_a?(Hash) && new_val.is_a?(Hash)
              deep_merge(old_val, new_val)
            else
              new_val
            end
          end
        end

        def deep_merge!(hash1, hash2)
          hash2.each do |key, new_val|
            if hash1[key].is_a?(Hash) && new_val.is_a?(Hash)
              deep_merge!(hash1[key], new_val) # Recursively merge nested hashes
            else
              hash1[key] = new_val # Overwrite or add the value from hash2
            end
          end
          hash1
        end

        private

        # Helper method to delete a key from a hash recursively
        def delete_key_from_hash(hash, key_to_delete)
          hash.each_with_object({}) do |(key, value), result|
            unless key == key_to_delete
              result[key] = deep_delete_key(value, key_to_delete)
            end
          end
        end

        # Helper method to recursively delete keys from array elements
        def delete_key_from_array(array, key_to_delete)
          array.map { |item| deep_delete_key(item, key_to_delete) }
        end

        # Helper: Traverse a nested hash or array
        def traverse_data(data, &block)
          case data
          when Hash
            data.each_with_object({}) do |(key, value), result|
              result[key] = yield(key, traverse_data(value, &block))
            end
          when Array
            data.map { |item| traverse_data(item, &block) }
          else
            data
          end
        end
      end
    end
  end
end
