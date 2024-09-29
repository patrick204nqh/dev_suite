# frozen_string_literal: true

require_relative "key_handler"

module DevSuite
  module Utils
    module Data
      module PathAccess
        module DataTraverser
          extend self

          # Traverse nested data for retrieving a value
          def fetch(data, keys)
            keys.reduce(data) { |current, key| traverse_data(current, key) }
          end

          # Traverse nested data for setting a value
          def assign(data, keys, value)
            last_key = keys.pop
            target = keys.reduce(data) { |current, key| traverse_or_create(current, key) }
            set_final_value(target, last_key, value)
          end

          # Traverse nested data for deleting a value
          def remove(data, keys)
            last_key = keys.pop
            target = keys.reduce(data) { |current, key| traverse_data(current, key) }
            delete_final_value(target, last_key)
          end

          private

          # Traverse through hash or array data types
          def traverse_data(current, key)
            KeyHandler.validate_path(current, key)
            case current
            when Hash
              current[KeyHandler.find_key(current, key)]
            when Array
              current[key.to_i]
            else
              raise DataStructureError, "Unexpected data type at '#{key}'"
            end
          end

          # Traverse or create new hash elements when setting a value
          def traverse_or_create(current, key)
            KeyHandler.validate_path(current, key)
            case current
            when Hash
              current[KeyHandler.find_key(current, key)] ||= {}
            when Array
              current[key.to_i] ||= {}
            else
              raise DataStructureError, "Unexpected data type at '#{key}'"
            end
          end

          # Set the final value in hash or array
          def set_final_value(target, key, value)
            case target
            when Hash
              target[KeyHandler.find_key(target, key)] = value
            when Array
              target[key] = value if key.is_a?(Integer)
            else
              raise DataStructureError, "Cannot set value on unsupported data type"
            end
          end

          # Delete the final value from hash or array
          def delete_final_value(target, key)
            case target
            when Hash
              target.delete(KeyHandler.find_key(target, key))
            when Array
              target.delete_at(key) if key.is_a?(Integer)
            else
              raise DataStructureError, "Cannot delete key from unsupported data type"
            end
          end
        end
      end
    end
  end
end
