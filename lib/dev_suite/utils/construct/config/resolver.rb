# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Resolver
          extend self

          # Resolves the value of an attribute based on its resolver.
          # If no resolver is provided, the value is returned as is.
          #
          # @param value [Object] The value to resolve.
          # @param resolver [Proc] The resolver to use for the attribute.
          def resolve_attr(value:, resolver:)
            resolver ? resolver.call(value) : value
          end
        end
      end
    end
  end
end
