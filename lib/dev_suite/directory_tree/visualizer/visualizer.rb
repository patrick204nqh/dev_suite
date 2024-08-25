# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      include Utils::Construct::Component

      require "pathname"

      require_relative "base"
      require_relative "tree"

      register_component(Tree)
    end
  end
end
