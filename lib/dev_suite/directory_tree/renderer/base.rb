# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      class Base
        attr_reader :settings

        def initialize(settings: Settings.new)
          @settings = settings
        end

        # Render the tree
        # @param node [Node::Base] The node to render
        # @param prefix [String] The prefix to add to the node
        # @param is_last [Boolean] Is this the last node in the list?
        # @return [String] The rendered tree
        # @abstract
        # @raise [NotImplementedError] If the method is not implemented in the subclass
        # @example
        #  render(node, prefix, is_last)
        #  # => "├── file1\n└── file2\n"
        #  render(node, prefix, true)
        #  # => "└── file1\n"
        #  render(node, prefix, false)
        #  # => "├── file1\n"
        def render(node, prefix = "", is_last = true)
          raise NotImplementedError, "You must implement the render method"
        end
      end
    end
  end
end
