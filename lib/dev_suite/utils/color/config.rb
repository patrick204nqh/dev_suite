# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      class Config
        attr_accessor :strategy, :palette

        def initialize(strategy: :theme, palette: :default)
          @palette = Palette.create(palette)
          @strategy = Strategy.create(strategy, palette: @palette)
          freeze # Make the instance of this class immutable as well
        end

        class << self
          #
          # Provide global access to a single instance of Config
          #
          def configuration
            @configuration ||= new
          end

          # Allow block-based configuration
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
