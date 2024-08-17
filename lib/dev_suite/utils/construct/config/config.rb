# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        require_relative "attribute_management"
        require_relative "hook_management"
        require_relative "validator"
        require_relative "resolver"
        require_relative "base"
        require_relative "configuration"
        require_relative "settings"

        class << self
          def included(base)
            base.extend(ClassMethods)
            define_constants(base)
          end

          private

          def define_constants(base)
            base.const_set(:BaseConfiguration, Configuration)

            unless base.const_defined?(:Configuration)
              base.const_set(:Configuration, Class.new(base::BaseConfiguration))
            end
          end
        end

        module ClassMethods
          # Provides access to a single instance of the configuration class
          # It dynamically uses the Configuration class in the including module's namespace
          def configuration
            @configuration ||= self::Configuration.new
          end

          # Allows block-based configuration
          # Example usage:
          #   ConfigClass.configure do |config|
          #     config.attr_name = value
          #   end
          def configure
            yield(configuration)
          rescue StandardError => e
            ErrorHandler.handle_error(e)
          end

          # Resets the configuration by reinitializing it with default values
          def reset!
            @configuration = self::Configuration.new # Reinitialize the configuration instance
          end
        end
      end
    end
  end
end
