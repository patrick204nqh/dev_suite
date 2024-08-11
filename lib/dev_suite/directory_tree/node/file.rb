# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Node
      class File < Base
        def file?
          true
        end
      end
    end
  end
end
