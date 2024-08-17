# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module AttributeManagement
          class << self
            def included(base)
              base.extend(ClassMethods)
            end
          end

          module ClassMethods
            def config_attr(attr, default_value: nil, type: nil, resolver: nil)
              config_attrs[attr] = { default_value: default_value, type: type, resolver: resolver }
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
              define_method(attr) { instance_variable_get("@#{attr}") }
              define_method("#{attr}=") do |value|
                validate_and_set_config_attr(attr: attr, value: value)
              end
            end
          end

          private

          def initialize_config_attrs
            self.class.config_attrs.each do |attr, details|
              send("#{attr}=", details[:default_value]) unless instance_variable_defined?("@#{attr}")
            end
          end

          def validate_and_set_config_attr(attr:, value:)
            attr_details = self.class.config_attrs[attr]
            type, resolver = attr_details.values_at(:type, :resolver)

            Validator.validate_attr_type!(attr: attr, value: value, type: type) if type
            resolved_value = resolver ? Resolver.resolve_attr(value: value, resolver: resolver) : value
            instance_variable_set("@#{attr}", resolved_value)
          end
        end
      end
    end
  end
end
