# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module SearchFilter
        # Deep search for all occurrences of a key
        def deep_find_by_key(data, search_key)
          result = []
          traverse_and_collect(data) do |key, value|
            result << value if key == search_key
          end
          result
        end

        # Recursively filter a nested hash or array based on a key-value condition
        def deep_filter_by_key_value(data, filter_key, filter_value)
          case data
          when Hash
            filter_hash_by_key_value(data, filter_key, filter_value)
          when Array
            filter_array_by_key_value(data, filter_key, filter_value)
          else
            raise ArgumentError, "Unsupported data type: #{data.class}"
          end
        end

        private

        # Helper method to filter a hash by a key-value condition
        def filter_hash_by_key_value(hash, filter_key, filter_value)
          return hash if hash[filter_key] == filter_value

          hash.each_with_object({}) do |(key, value), result|
            filtered_value = deep_filter_by_key_value(value, filter_key, filter_value)
            result[key] = filtered_value unless filtered_value.nil? || filtered_value.empty?
          end
        end

        # Helper method to filter an array by a key-value condition
        def filter_array_by_key_value(array, filter_key, filter_value)
          array.map { |item| deep_filter_by_key_value(item, filter_key, filter_value) }.compact
        end

        # Helper method to traverse and collect values
        def traverse_and_collect(data, &block)
          case data
          when Hash
            data.each do |key, value|
              block.call(key, value)
              traverse_and_collect(value, &block)
            end
          when Array
            data.each { |item| traverse_and_collect(item, &block) }
          end
        end
      end
    end
  end
end
