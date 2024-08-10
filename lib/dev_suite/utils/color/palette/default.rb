# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        class Default < Base
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
        end
      end
    end
  end
end
