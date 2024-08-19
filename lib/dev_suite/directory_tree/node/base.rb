# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Node
      class Base
        attr_reader :name

        def initialize(name)
          @name = name
        end

        def directory?
          false
        end

        def file?
          false
        end

        def children
          []
        end

        def to_h
          {
            name: @name,
            children: children.map(&:to_h),
          }
        end

        def hidden?
          @name.start_with?(".")
        end
      end
    end
  end
end
