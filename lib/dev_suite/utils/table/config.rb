# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Config
        DEFAULTS = {
          colors: {
            title: :cyan,
            column: :yellow,
            row: :default,
            border: :blue,
          },
          alignments: {
            column: :left,
            row: :left,
          },
        }.freeze

        attr_reader :settings

        def initialize(settings = {})
          @settings = deep_merge(DEFAULTS, settings)
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
          end

          private

          def handle_configuration_error(error)
            puts "Configuration error: #{error.message}"
          end
        end

        def color_for(key)
          @settings[:colors][key] || DEFAULTS[:colors][:row]
        end

        def alignment_for(key)
          @settings[:alignments][key] || :left
        end

        private

        def deep_merge(original, override)
          original.merge(override) do |_key, oldval, newval|
            oldval.is_a?(Hash) ? deep_merge(oldval, newval) : newval
          end
        end
      end
    end
  end
end
