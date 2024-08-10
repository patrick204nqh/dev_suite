# frozen_string_literal: true

require "pathname"

module DevSuite
  module DirectoryTree
    module Renderer
      class Base
        def render(path)
          raise ArgumentError, "Invalid path" unless valid_path?(path)

          root = build_tree(Pathname.new(path))
          render_node(root, "", true)
        end

        private

        def valid_path?(path)
          [
            path.is_a?(String),
            ::File.exist?(path),
            ::File.directory?(path),
            ::File.readable?(path),
          ].all?
        end

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
