# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Settings
          class Base
            def initialize(settings = {})
              @default_settings = settings
              @settings = merge_settings(@default_settings, settings)
            end

            def set(*keys, value)
              key_path = normalize_keys(keys)
              last_key = key_path.pop
              target = key_path.each_with_object(@settings) do |key, nested|
                nested[key] ||= {}
              end
              target[last_key] = value
            end

            def get(*keys, default_value)
              key_path = normalize_keys(keys)
              value = fetch_value_from_path(key_path)
              value.nil? ? default_value : value
            end

            def reset!
              @settings = @default_settings
            end

            private

            def normalize_keys(keys)
              key_path = keys.flatten
              if key_path.size == 1 && key_path.first.is_a?(String)
                key_path.first.to_s.split(".").map(&:to_sym)
              else
                key_path.map(&:to_sym)
              end
            end

            def merge_settings(defaults, overrides)
              defaults.merge(overrides) do |_key, oldval, newval|
                if oldval.is_a?(Hash) && newval.is_a?(Hash)
                  merge_settings(oldval, newval)
                else
                  newval
                end
              end
            end

            def fetch_value_from_path(key_path)
              key_path.reduce(@settings) do |nested, key|
                return nil unless nested.is_a?(Hash)

                nested[key]
              end
            end
          end
        end
      end
    end
  end
end
