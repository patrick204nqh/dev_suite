# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module Transformations
        # Recursively convert all values to strings without altering the structure
        def deep_stringify_values(data)
          case data
          when Hash
            data.each_with_object({}) do |(key, value), result|
              result[key] = deep_stringify_values(value) # Recursively process nested values
            end
          when Array
            data.map { |item| deep_stringify_values(item) }
          else
            data.to_s # Only convert the value itself to a string
          end
        end

        # Recursively symbolize keys in a nested structure
        def deep_symbolize_keys(data)
          traverse_transform(data) { |key, value| [key.to_sym, value] }
        end

        private

        # Helper method for transforming structures
        def traverse_transform(data, &block)
          case data
          when Hash
            data.each_with_object({}) do |(key, value), result|
              new_key, new_value = block.call(key, traverse_transform(value, &block))
              result[new_key] = new_value
            end
          when Array
            data.map { |item| traverse_transform(item, &block) }
          else
            data
          end
        end
      end
    end
  end
end
