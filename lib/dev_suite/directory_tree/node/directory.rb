# frozen_string_literal: true

require_relative "base"

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

        def add_child(child)
          @children << child
        end
      end
    end
  end
end
