# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module PathAccess
        require_relative "path_access/path_accessor"

        # Fetch value from a nested structure using a path
        def get_value_by_path(data, path)
          PathAccessor.get(data, path)
        end

        # Set value in a nested structure using a path
        def set_value_by_path(data, path, value)
          PathAccessor.set(data, path, value)
        end

        # Delete a key from a nested structure using a path
        def delete_key_by_path(data, path)
          PathAccessor.delete(data, path)
        end
      end
    end
  end
end
