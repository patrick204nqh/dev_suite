# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          require_relative "validator"

          module AttrResolving
            private

            # Sets a configuration attribute value with validation and resolution
            def set_config_attr(attr:, value:)
              attr_details = fetch_attr_details(attr)

              store_original_value(attr, value)
              validated_value = validate_config_attr(attr, value, attr_details)
              resolved_value = resolve_config_attr_value(attr, validated_value, attr_details)

              store_resolved_value(attr, resolved_value)
            end

            # Fetches the details of a configuration attribute
            def fetch_attr_details(attr_name)
              self.class.config_attrs[attr_name]
            end

            # Stores the original value of an attribute before processing
            def store_original_value(attr_name, value)
              instance_variable_set("@original_#{attr_name}", value)
            end

            # Stores the resolved value of an attribute after processing
            def store_resolved_value(attr_name, value)
              instance_variable_set("@#{attr_name}", value)
            end

            # Validates the value of a configuration attribute
            def validate_config_attr(attr_name, value, attr_details)
              if attr_details[:type]
                Validator.validate_config_attr_type!(
                  attr: attr_name,
                  value: value,
                  type: attr_details[:type],
                )
              end
              value
            end

            # Resolves the value of a configuration attribute
            def resolve_config_attr_value(attr_name, value, attr_details)
              if attr_details[:resolver]
                resolve_config_attr(
                  value: value,
                  resolver: attr_details[:resolver],
                )
              else
                value
              end
            end

            # Resolves the value of an attribute based on its resolver.
            # If no resolver is provided, the value is returned as is.
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
