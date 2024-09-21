# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        class Base
          class << self
            # Returns the key for the class. If the COMPONENT_KEY constant is defined, it returns its value.
            # Otherwise, it generates a key based on the class name.
            def component_key
              return const_get(:COMPONENT_KEY) if const_defined?(:COMPONENT_KEY)

              generate_key_from_class_name
            end

            private

            # Generates a key from the class name by converting it to snake_case and symbolizing it.
            def generate_key_from_class_name
              class_name = name.split("::").last
              snake_case_class_name = class_name.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
              snake_case_class_name.to_sym
            end
          end

          private

          # Fetches a setting based on the provided key.
          # This method should be overridden by subclasses to provide specific behavior.
          #
          # @param key [String] The key for the setting.
          # @param default [Object] The default value to return if the key is not found.
          def fetch_setting(_key, _default = nil)
            # Example implementation
            # Config.configuration.settings.get(key, default)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
