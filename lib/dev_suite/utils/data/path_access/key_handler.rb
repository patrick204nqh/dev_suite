# frozen_string_literal: true

module DevSuite
  module Utils
    module Data
      module PathAccess
        module KeyHandler
          extend self

          # Find an existing key in a hash, handling both symbol and string keys
          def find_key(hash, key)
            return key if hash.key?(key)
            return key.to_s if hash.key?(key.to_s)
            return key.to_sym if hash.key?(key.to_sym)

            key
          end

          # Validate the path by checking if it's pointing to a valid data structure
          def validate_path(data, key)
            raise InvalidPathError, "Invalid path at '#{key}'" if data.nil?
          end
        end
      end
    end
  end
end
