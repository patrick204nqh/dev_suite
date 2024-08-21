# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        require_relative "renderer/base"
        require_relative "renderer/simple"

        include Construct::ComponentManager

        register_component(:simple, Simple)
      end
    end
  end
end
