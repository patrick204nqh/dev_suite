# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Node
      class Directory < Base
        attr_reader :children

        def initialize(name)
          super
          @children = []
        end

        def directory?
          true
        end

        def add_child(node)
          @children << node
          sort_children!
        end

        private

        def sort_children!
          @children.sort_by! do |node|
            [
              node.hidden? ? 1 : 0, # Hidden nodes should be at the end
              node.name.downcase,   # Alphabetical order
            ]
          end
        end
      end
    end
  end
end
