# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      require_relative "renderer/base"
      require_relative "renderer/simple"

      include Utils::Construct::ComponentManager

      register_component(:simple, Simple)
    end
  end
end
