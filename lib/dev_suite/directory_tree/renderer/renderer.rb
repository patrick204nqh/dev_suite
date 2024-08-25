# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      include Utils::Construct::Component

      require_relative "base"
      require_relative "simple"

      register_component(Simple)
    end
  end
end
