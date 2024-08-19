# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          module Resolver
            extend self

            # Resolves the value of an attribute based on its resolver.
            # If no resolver is provided, the value is returned as is.
            #
            # @param value [Object] The value to resolve.
            # @param resolver [Proc] The resolver to use for the attribute.
            def resolve_config_attr(value:, resolver:)
              case resolver
              when Proc
                resolver.call(value)
              when Symbol
                send(resolver, value)
              else
                value
              end
            end
          end
        end
      end
    end
  end
end
