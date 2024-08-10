# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        class Theme < Base
          def initialize(palette)
            super()
            @palette = palette
          end

          def colorize(text, color: :default)
            unless @palette.colors.key?(color)
              raise ArgumentError, "Invalid color key"
            end

            color_code = @palette.colors[color]

            unless valid_color_code?(color_code)
              raise ArgumentError, "Invalid color code"
            end

            "\e[#{color_code}m#{text}\e[0m"
          end

          private

          def valid_color_code?(color_code)
            color_code.is_a?(Integer) && color_code.between?(0, 255)
          end
        end
      end
    end
  end
end
