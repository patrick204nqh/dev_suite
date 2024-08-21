# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      require "pathname"

      require_relative "visualizer/base"
      require_relative "visualizer/tree"

      include Utils::Construct::ComponentManager

      register_component(:tree, Tree)
    end
  end
end
