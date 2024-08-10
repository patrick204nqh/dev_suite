# frozen_string_literal: true

require_relative "base"

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
