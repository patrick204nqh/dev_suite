# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          module AttrDefinition
            def config_attr(attr, default_value: nil, type: nil, resolver: nil)
              config_attrs[attr] = build_attr_details(
                default_value: default_value,
                type: type,
                resolver: resolver,
              )
              define_config_attr_methods(attr)
            end

            def config_attrs
              @config_attrs ||= {}
            end

            def config_attr_present?(attr)
              config_attrs.key?(attr)
            end

            private

            def build_attr_details(default_value:, type:, resolver:)
              {
                default_value: default_value,
                type: type,
                resolver: resolver,
              }
            end

            def define_config_attr_methods(attr)
              define_getter_methods(attr)
              define_setter_methods(attr)
            end

            def define_getter_methods(attr)
              define_method(attr) do
                instance_variable_get("@#{attr}")
              end

              define_method("original_#{attr}") do
                instance_variable_get("@original_#{attr}")
              end
            end

            def define_setter_methods(attr)
              define_method("#{attr}=") do |value|
                set_config_attr(attr: attr, value: value)
              end
            end
          end
        end
      end
    end
  end
end
