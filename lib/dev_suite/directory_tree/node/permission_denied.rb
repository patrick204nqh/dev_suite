# frozen_string_literal: true

require_relative "base"

module DevSuite
  module DirectoryTree
    module Node
      class PermissionDenied < Base
        # This class is used to represent a file or directory that the user does not have permission to access.
        def initialize(name, is_directory)
          super(name)
          @is_directory = is_directory
        end

        def directory?
          @is_directory
        end

        def children
          []
        end
      end
    end
  end
end
