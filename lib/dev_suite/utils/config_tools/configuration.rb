# frozen_string_literal: true

module DevSuite
  module Utils
    module ConfigTools
      module Configuration
        # Module for global configuration
        class << self
          def included(base)
            base.extend(ClassMethods)
            base.include(InstanceMethods)
          end
        end

        module ClassMethods
          # Provides global access to a single instance of the configuration class
          # @return [Object] The singleton configuration instance
          def configuration
            @configuration ||= new
          end

          # Allows block-based configuration
          # Example usage:
          #   ConfigClass.configure do |config|
          #     config.attr_name = value
          #   end
          def configure
            yield(configuration)
          rescue StandardError => e
            ErrorHandler.handle_error(e)
          end

          # Defines a configuration attribute with an optional default value
          # This method automatically creates getter and setter methods for the attribute
          #
          # @param attr_name [Symbol] The name of the attribute
          # @param default_value [Object] The default value for the attribute
          def config_attr(attr_name, default_value: nil)
            config_attrs[attr_name] = default_value

            # Getter method for the attribute
            define_method(attr_name) do
              instance_variable_get("@#{attr_name}")
            end

            # Setter method for the attribute with validation and resolution
            define_method("#{attr_name}=") do |value|
              validate_attr!(attr_name, value)
              instance_variable_set("@#{attr_name}", resolve_attr(attr_name, value))
            end
          end

          # Stores configuration attributes and their default values
          # @return [Hash] A hash of attribute names and their default values
          def config_attrs
            @config_attrs ||= {}
          end
        end

        # Module for instance-level methods
        module InstanceMethods
          private

          # Initializes configuration attributes with provided or default values
          # This method is called automatically during object initialization
          #
          # @param options [Hash] A hash of attribute names and their values
          def initialize(**options)
            initialize_attributes(options)
          end

          # Sets up each attribute with either the provided value or the default value
          #
          # @param options [Hash] A hash of attribute names and their values
          def initialize_attributes(options)
            self.class.config_attrs.each do |attr_name, default_value|
              value = options.fetch(attr_name, default_value)
              send("#{attr_name}=", value)
            end
          end

          # Validates an attribute's value based on its type
          # Override this method in the including class to add custom validation logic
          #
          # @param attr [Symbol] The name of the attribute
          # @param value [Object] The value to validate
          def validate_attr!(attr, value)
            raise ArgumentError, "Unknown attribute: #{attr}" unless self.class.config_attrs.key?(attr)
            raise ArgumentError, "Invalid #{attr} value: #{value}" if value.nil?

            # Override in including class to add custom validation logic
          end

          # Validates that an attribute's value is a Hash
          #
          # @param attr [Symbol] The name of the attribute
          # @param value [Object] The value to validate
          def validate_hash!(attr, value)
            raise ArgumentError, "Invalid #{attr} value: expected a Hash" unless value.is_a?(Hash)
          end

          # Validates that an attribute's value is a Symbol
          #
          # @param attr [Symbol] The name of the attribute
          # @param value [Object] The value to validate
          def validate_symbol!(attr, value)
            raise ArgumentError, "Invalid #{attr} value: expected a Symbol" unless value.is_a?(Symbol)
          end

          # Validates that an attribute's value is an Array
          #
          # @param attr [Symbol] The name of the attribute
          # @param value [Object] The value to validate
          def validate_array!(attr, value)
            raise ArgumentError, "Invalid #{attr} value: expected an Array" unless value.is_a?(Array)
          end

          # Resolves the value of an attribute, especially if it requires
          # converting a symbol to an object. Override in the including class.
          #
          # @param _attr [Symbol] The name of the attribute
          # @param value [Object] The value to resolve
          # @return [Object] The resolved value
          def resolve_attr(attr, value)
            raise ArgumentError, "Unknown attribute: #{attr}" unless self.class.config_attrs.key?(attr)

            # Override in including class to resolve symbols to objects
            value
          end
        end
      end
    end
  end
end
