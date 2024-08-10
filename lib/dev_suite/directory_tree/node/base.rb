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
          raise NotImplementedError, "Must implement in subclass"
        end
      end
    end
  end
end
