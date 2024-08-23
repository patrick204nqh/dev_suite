# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Attribute
          module AttrDefinition
            def config_attr(attr, default_value: nil, type: nil, resolver: nil)
              config_attrs[attr] = {
                default_value: default_value,
                type: type,
                resolver: resolver,
              }
              define_config_attr_methods(attr)
            end

            def config_attrs
              @config_attrs ||= {}
            end

            def config_attr_present?(attr)
              config_attrs.key?(attr)
            end

            private

            def define_config_attr_methods(attr)
              define_method(attr) do
                instance_variable_get("@#{attr}")
              end

              define_method("original_#{attr}") do
                instance_variable_get("@original_#{attr}")
              end

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
