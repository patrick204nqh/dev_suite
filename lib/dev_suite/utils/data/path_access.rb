# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module PathAccess
        # Fetch value from a nested structure using a path
        def get_value_by_path(data, path)
          keys = parse_path(path)
          keys.reduce(data) do |current_data, key|
            raise KeyError, "Invalid path at '#{key}'" if current_data.nil?

            case current_data
            when Hash
              current_data[key.to_sym] || current_data[key.to_s]
            when Array
              key.is_a?(Integer) ? current_data[key] : nil
            end
          end
        end

        # Set value in a nested structure using a path
        def set_value_by_path(data, path, value)
          keys = parse_path(path)
          last_key = keys.pop
          target = keys.reduce(data) do |current_data, key|
            raise KeyError, "Invalid path at '#{key}'" if current_data.nil?

            case current_data
            when Hash
              current_data[key.to_sym] ||= {}
            when Array
              current_data[key.to_i] ||= {}
            else
              break nil
            end
          end

          if target.is_a?(Hash)
            target[last_key.to_sym] = value
          elsif target.is_a?(Array) && last_key.is_a?(Integer)
            target[last_key] = value
          else
            raise KeyError, "Invalid path or type at '#{last_key}'"
          end
        end

        private

        # Parse the path into an array of keys/symbols/integers
        def parse_path(path)
          return path if path.is_a?(Array)

          path.to_s.split(/\.|\[|\]/).reject(&:empty?).map do |part|
            part.match?(/^\d+$/) ? part.to_i : part.to_sym
          end
        end
      end
    end
  end
end
