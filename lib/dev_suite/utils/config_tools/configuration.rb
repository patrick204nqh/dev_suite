# frozen_string_literal: true

module DevSuite
  module Utils
    module ConfigTools
      module Configuration
        # Module for global configuration
        class << self
          def included(base)
            base.extend(ClassMethods)
            base.include(InstanceMethods)
          end
        end

        module ClassMethods
          #
          # Provide global access to a single instance of Config
          #
          def configuration
            @configuration ||= new
          end

          #
          # Allow block-based configuration
          #
          def configure
            yield(configuration)
          rescue StandardError => e
            ErrorHandler.handle_error(e)
          end

          def config_attr(*attrs)
            attrs.each do |attr|
              define_method(attr) do
                instance_variable_get("@#{attr}") || instance_variable_get("@#{attr}_resolved")
              end

              define_method("#{attr}=") do |value|
                validate_config_attr(attr, value)
                instance_variable_set("@#{attr}", resolve_config_attr(attr, value))
              end
            end
          end
        end

        module InstanceMethods
          private

          def validate_config_attr!(attr, value)
            # Override in including class for custom validation logic
          end

          def resolve_config_attr(attr, value)
            # Override in including class to resolve symbols to objects
            value
          end

          def initialize(**options)
            options.each do |key, value|
              send("#{key}=", value) if respond_to?("#{key}=")
            end
          end
        end
      end
    end
  end
end
