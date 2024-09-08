# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      require_relative "base_operations"
      require_relative "transformations"
      require_relative "search_filter"
      require_relative "path_access"
      require_relative "serialization"

      extend BaseOperations
      extend Transformations
      extend SearchFilter
      extend PathAccess
      extend Serialization
    end
  end
end
