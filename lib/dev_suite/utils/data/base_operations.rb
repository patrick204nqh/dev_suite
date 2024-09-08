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

        # Non-destructive deep merge
        def deep_merge(hash1, hash2)
          hash1 = hash1.dup # Ensure we don't modify the original hash1
          deep_merge!(hash1, hash2)
        end

        # Destructive deep merge (modifies hash1)
        def deep_merge!(hash1, hash2)
          return hash1 if hash2.nil? # If hash2 is nil, return hash1 as-is

          hash2.each do |key, new_val|
            if hash1[key].is_a?(Hash) && new_val.is_a?(Hash)
              # Recursively merge nested hashes
              deep_merge!(hash1[key], new_val)
            else
              # Overwrite or add the value from hash2
              hash1[key] = new_val
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
