# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Formatter
        class Colorizer
          COLORS = {
            red: 31,
            green: 32,
            yellow: 33,
            blue: 34,
            magenta: 35,
            cyan: 36,
            white: 37,
            default: 39,
          }.freeze

          class << self
            def code_for(color)
              COLORS[color] || COLORS[:default]
            end

            def colorize(text, color = :default)
              color_code = code_for(color)
              "\e[#{color_code}m#{text}\e[0m"
            end
          end
        end
      end
    end
  end
end
