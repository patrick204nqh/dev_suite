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
            # Only include the hash if it has the matching key-value pair
            return data if data[filter_key] == filter_value

            # Continue to filter nested hashes
            data.each_with_object({}) do |(key, value), result|
              filtered_value = deep_filter_by_key_value(value, filter_key, filter_value)
              result[key] = filtered_value unless filtered_value.nil? || filtered_value.empty?
            end
          when Array
            # Recursively filter each item in the array
            data.map { |v| deep_filter_by_key_value(v, filter_key, filter_value) }.compact
          else
            raise ArgumentError, "Unsupported data type: #{data.class}"
          end
        end

        private

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
