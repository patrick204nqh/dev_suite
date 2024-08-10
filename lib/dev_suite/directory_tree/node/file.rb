# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Node
      class File < Base
        def directory?
          false
        end
      end
    end
  end
end
