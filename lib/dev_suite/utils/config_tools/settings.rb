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

          def apply
            #
            # Implement logic to apply settings in the including class
            # TODO: need to review this method
            #
            raise NotImplementedError, "#{self.class} must implement the #apply method"
          end

          def reset!
            @settings = default_settings
          end

          def default_settings
            raise NotImplementedError, "#{self.class} must implement the #default_settings method"
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
        end
      end
    end
  end
end
