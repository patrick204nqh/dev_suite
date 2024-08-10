# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        require_relative "strategy/base"
        require_relative "strategy/basic"
        require_relative "strategy/rgb"
        require_relative "strategy/theme"

        class << self
          def create(type, palette: nil)
            case type
            when :basic
              Basic.new
            when :rgb
              Rgb.new
            when :theme
              raise ArgumentError, "Palette is required for theme strategy" unless palette

              Theme.new(palette)
            else
              raise ArgumentError, "Unknown strategy type: #{type}"
            end
          end
        end
      end
    end
  end
end
