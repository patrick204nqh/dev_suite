# frozen_string_literal: true

require "pathname"

module DevSuite
  module DirectoryTree
    module Renderer
      class Base
        def initialize(base_path)
          @base_path = Pathname.new(base_path)
        end

        def render
          root = build_tree(@base_path)
          render_node(root, "", true)
        end

        private

        # Builds the tree structure
        # @param path [Pathname] The path to build the tree from
        # @return [Node::Base] The root node of the tree
        def build_tree(path)
          raise NotImplementedError, "You must implement the build_tree method"
        end

        # Renders a node in the tree
        # @param node [Node::Base] The node to render
        # @param prefix [String] The prefix to add to the node
        # @param is_last [Boolean] Whether this is the last node in the list
        # @return [String] The rendered node
        def render_node(node, prefix, is_last)
          raise NotImplementedError, "You must implement the render_node method"
        end
      end
    end
  end
end
