# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        class Base
          # Define COLORS constant in subclass
          # Example:
          # COLORS = {
          #  red: 31,
          #  green: 32,
          #  yellow: 33,
          #  blue: 34,
          #  pink: 35,
          #  light_blue: 36,
          #  white: 37
          #  }
          #

          def colors
            unless self.class.const_defined?(:COLORS)
              raise NotImplementedError, "#{self.class} must define COLORS constant"
            end

            self.class::COLORS
          end
        end
      end
    end
  end
end
