# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        include Construct::Component

        require_relative "base"
        require_relative "basic"
        require_relative "rgb"
        require_relative "theme"

        register_component(Basic)
        register_component(Rgb)
        register_component(Theme)
      end
    end
  end
end
