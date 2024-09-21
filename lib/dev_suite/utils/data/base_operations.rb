# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module BaseOperations
        # Recursively delete a key from any level in the data structure
        def deep_delete_key(data, key_to_delete)
          case data
          when Hash, Array
            delete_key_from_structure(data, key_to_delete)
          else
            data
          end
        end

        # Destructive deep merge (modifies hash1)
        def deep_merge!(hash1, hash2)
          return hash1 if hash2.nil?

          hash2.each do |key, new_val|
            hash1[key] = merge_value(hash1[key], new_val)
          end
          hash1
        end

        # Non-destructive deep merge
        def deep_merge(hash1, hash2)
          deep_merge!(hash1.dup, hash2)
        end

        private

        # Helper to merge individual values based on their types
        def merge_value(old_val, new_val)
          if old_val.is_a?(Hash) && new_val.is_a?(Hash)
            deep_merge!(old_val, new_val)
          else
            new_val
          end
        end

        # Helper method to delete key from both Hash and Array recursively
        def delete_key_from_structure(data, key_to_delete)
          case data
          when Hash
            data.each_with_object({}) do |(key, value), result|
              unless key == key_to_delete
                result[key] = deep_delete_key(value, key_to_delete)
              end
            end
          when Array
            data.map { |item| deep_delete_key(item, key_to_delete) }
          else
            data
          end
        end
      end
    end
  end
end
