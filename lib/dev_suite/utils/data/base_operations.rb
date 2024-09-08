# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module BaseOperations
        # Recursively delete a key from any level in the data structure
        def deep_delete_key(data, key_to_delete)
          case data
          when Hash
            # Remove the key and recurse into nested structures
            data.each_with_object({}) do |(key, value), result|
              result[key] = deep_delete_key(value, key_to_delete) unless key == key_to_delete
            end
          when Array
            # Recurse into array elements
            data.map { |item| deep_delete_key(item, key_to_delete) }
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

        private

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
