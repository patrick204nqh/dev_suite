require_relative 'color_palette'

module DevSuite
  module Utils
    module Color
      class Colorizer
        def colorize(text, color = :default)
          color_code = ColorPalette.code_for(color)
          "\e[#{color_code}m#{text}\e[0m"
        end
      end
    end
  end
end
