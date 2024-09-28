# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        class Default < Base
          COLORS = {
            # Standard Colors
            black: 30,
            red: 31,
            green: 32,
            yellow: 33,
            blue: 34,
            magenta: 35,
            cyan: 36,
            white: 37,
            default: 39,

            # Light Colors
            light_black: 90,
            light_red: 91,
            light_green: 92,
            light_yellow: 93,
            light_blue: 94,
            light_magenta: 95,
            light_cyan: 96,
            light_white: 97,

            # Background Colors
            bg_black: 40,
            bg_red: 41,
            bg_green: 42,
            bg_yellow: 43,
            bg_blue: 44,
            bg_magenta: 45,
            bg_cyan: 46,
            bg_white: 47,
            bg_default: 49,

            # Light Background Colors
            bg_light_black: 100,
            bg_light_red: 101,
            bg_light_green: 102,
            bg_light_yellow: 103,
            bg_light_blue: 104,
            bg_light_magenta: 105,
            bg_light_cyan: 106,
            bg_light_white: 107,
          }.freeze
        end
      end
    end
  end
end
