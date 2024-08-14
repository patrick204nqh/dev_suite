# frozen_string_literal: true

module DevSuite
  module Utils
    module ConfigTools
      # Module for managing instance settings
      module Settings
        class << self
          def included(base)
            base.include(InstanceMethods)
          end
        end

        module InstanceMethods
          def initialize(settings = {})
            @settings = merge_settings(default_settings, settings)
          end

          def set(*keys, value)
            validate_setting!(keys, value) # Validate before setting
            key_path = normalize_keys(keys)
            last_key = key_path.pop
            target = key_path.each_with_object(@settings) do |key, nested|
              nested[key] ||= {}
            end
            target[last_key] = value
          end

          def get(*keys)
            key_path = normalize_keys(keys)
            key_path.reduce(@settings) do |nested, key|
              nested.is_a?(Hash) ? nested[key] : nil
            end
          end

          def reset!
            @settings = merge_settings(default_settings, {})
          end

          def default_settings
            raise NotImplementedError, "#{self.class} must implement the #default_settings method"
          end

          private

          def validate_setting!(keys, value)
            # Implement validation logic as needed
            # Example: raise ArgumentError, "Invalid value for #{keys.join('.')}" if value.nil?
          end

          def normalize_keys(keys)
            keys.flatten.flat_map do |key|
              key.is_a?(String) ? key.split('.').map(&:to_sym) : key.to_sym
            end
          end

          def merge_settings(defaults, overrides)
            defaults.merge(overrides) do |_key, oldval, newval|
              if oldval.is_a?(Hash) && newval.is_a?(Hash)
                merge_settings(oldval, newval)
              elsif oldval.is_a?(Array) && newval.is_a?(Array)
                oldval + newval
              else
                newval
              end
            end
          end
        end
      end
    end
  end
end
