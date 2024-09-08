# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Settings
          class Base
            def initialize(settings = {})
              @default_settings = settings
              @settings = Utils::Data.deep_merge(@default_settings, settings)
            end

            def set(*keys, value)
              key_path = extract_path_from_keys(keys)
              Utils::Data.set_value_by_path(@settings, key_path, value)
            end

            def get(*keys, default: nil)
              key_path = extract_path_from_keys(keys)
              value = Utils::Data.get_value_by_path(@settings, key_path)
              value.nil? ? default : value
            end

            def reset!
              @settings = Utils::Data.deep_merge(@default_settings, {})
            end

            private

            # Extract path from mixed input (strings or arrays) and handle array-like syntax
            def extract_path_from_keys(keys)
              keys = keys.flatten

              # Handle case where keys is a single dot-separated string with array-like notation
              if keys.size == 1 && keys.first.is_a?(String)
                return parse_string_key(keys.first)
              end

              # Otherwise, symbolize all keys and convert string-based array indices
              keys.map { |key| parse_key_component(key) }
            end

            # Parse dot-separated strings and handle array-like notation (e.g., "users[1].avt")
            def parse_string_key(key)
              key.split(".").flat_map { |segment| parse_key_component(segment) }
            end

            # Parse individual components of the key (convert "users[1]" to [:users, 1])
            def parse_key_component(component)
              if component.match?(/\[\d+\]/)
                # Handle array-like notation in strings like "users[1]"
                component.scan(/[^\[\]]+/).map { |part| integer_or_symbol(part) }
              else
                integer_or_symbol(component)
              end
            end

            # Convert to integer if it's a number, otherwise symbolize
            def integer_or_symbol(part)
              part.match?(/^\d+$/) ? part.to_i : part.to_sym
            end
          end
        end
      end
    end
  end
end
