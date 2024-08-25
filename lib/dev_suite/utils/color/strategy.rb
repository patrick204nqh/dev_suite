# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        require_relative "strategy/base"
        require_relative "strategy/basic"
        require_relative "strategy/rgb"
        require_relative "strategy/theme"

        include Construct::Component

        register_component(:basic, Basic)
        register_component(:rgb, Rgb)
        register_component(:theme, Theme)
      end
    end
  end
end
