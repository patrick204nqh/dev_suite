# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        class Rgb < Base
          def colorize(text, **kwargs)
            r, g, b = kwargs.values_at(:r, :g, :b)

            unless valid_rgb?(r, g, b)
              raise ArgumentError, "RGB values must be integers between 0 and 255"
            end

            "\e[38;2;#{r};#{g};#{b}m#{text}\e[0m"
          end

          private

          def valid_rgb?(r, g, b)
            [r, g, b].all? { |value| value.is_a?(Integer) && value.between?(0, 255) }
          end
        end
      end
    end
  end
end
