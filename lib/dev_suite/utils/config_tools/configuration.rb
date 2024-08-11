# frozen_string_literal: true

module DevSuite
  module Utils
    module ConfigTools
      module Configuration
        # Module for global configuration
        class << self
          def included(base)
            base.extend(ClassMethods)
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
            handle_configuration_error(e)
            raise
          end

          private

          def handle_configuration_error(error)
            puts "Configuration error: #{error.message}"
          end
        end
      end
    end
  end
end
