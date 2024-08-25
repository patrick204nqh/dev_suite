# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        include Construct::Component

        require_relative "base"
        require_relative "simple"

        register_component(:simple, Simple)
      end
    end
  end
end
