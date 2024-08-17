# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        class Base
          class << self
            # Defines a configuration attribute with an optional default value and type.
            # Automatically creates getter and setter methods with validation and resolution.
            #
            # @param attr [Symbol] The name of the attribute.
            # @param default_value [Object] The default value for the attribute.
            # @param type [Symbol] The type of the attribute (e.g., :symbol, :hash).
            def config_attr(attr, default_value: nil, type: nil, resolver: nil)
              config_attrs[attr] = { default_value: default_value, type: type, resolver: resolver }
              define_attr_methods(attr)
            end

            # Stores configuration attributes and their default values
            # @return [Hash] A hash of attribute names and their default values
            def config_attrs
              @config_attrs ||= {}
            end

            def config_attr_present?(attr)
              config_attrs.key?(attr)
            end

            private

            # Define getter and setter methods for configuration attributes.
            def define_attr_methods(attr)
              define_method(attr) { instance_variable_get("@#{attr}") }
              define_method("#{attr}=") do |value|
                validate_and_set_attr(attr: attr, value: value)
              end
            end
          end

          # Initializes configuration attributes with provided or default values
          # This method is called automatically during object initialization
          #
          # @param options [Hash] A hash of attribute names and their values
          def initialize
            initialize_config_attrs
          end

          private

          # Sets up each config attribute with either the provided value or the default value
          #
          # @param options [Hash] A hash of attribute names and their values
          def initialize_config_attrs
            self.class.config_attrs.each do |attr, details|
              send("#{attr}=", details[:default_value]) unless instance_variable_defined?("@#{attr}")
            end
          end

          # Validate and set attributes based on their declared types.
          #
          # @param attr [Symbol] The name of the attribute.
          # @param value [Object] The value to validate and set.
          def validate_and_set_attr(attr:, value:)
            attr_details = self.class.config_attrs[attr]
            type, resolver = attr_details.values_at(:type, :resolver)

            Validator.validate_attr_type!(attr: attr, value: value, type: type) if type
            resolved_value = Resolver.resolve_attr(value: value, resolver: resolver)
            instance_variable_set("@#{attr}", resolved_value)
          end
        end
      end
    end
  end
end
