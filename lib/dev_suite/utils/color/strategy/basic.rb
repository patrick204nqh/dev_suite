# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        class Basic < Base
          def colorize(text, color: :default)
            unless valid_color_code?(color)
              raise ArgumentError, "Invalid color code"
            end

            "\e[#{color}m#{text}\e[0m"
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
