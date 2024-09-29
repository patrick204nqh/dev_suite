# frozen_string_literal: true

require_relative "path_parser"
require_relative "data_traverser"
require_relative "key_handler"
require_relative "errors"

module DevSuite
  module Utils
    module Data
      module PathAccess
        module PathAccessor
          extend self

          # Get value from nested data
          def get(data, path)
            keys = PathParser.parse(path)
            DataTraverser.fetch(data, keys)
          end

          # Set value in nested data
          def set(data, path, value)
            keys = PathParser.parse(path)
            DataTraverser.assign(data, keys, value)
          end

          # Delete key in nested data
          def delete(data, path)
            keys = PathParser.parse(path)
            DataTraverser.remove(data, keys)
          end
        end
      end
    end
  end
end
