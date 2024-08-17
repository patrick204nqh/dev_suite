# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Validator
          extend self

          # Validates an attribute's value based on its type.
          #
          # @param attr [Symbol] The name of the attribute.
          # @param value [Object] The value to validate.
          # @param type [Symbol] The expected type of the attribute.
          def validate_attr_type!(attr:, value:, type:)
            case type
            when :symbol
              validate_symbol!(value)
            when :hash
              validate_hash!(value)
            when :array
              validate_array!(value)
            when :class
              validate_instance_of!(value, Object)
            else
              raise ArgumentError, "Unknown type #{type} for attribute #{attr}"
            end
          end

          # Utility method to validate a Symbol.
          def validate_symbol!(value)
            raise ArgumentError, "Expected a Symbol, got #{value.class}" unless value.is_a?(Symbol)
          end

          # Utility method to validate a Hash.
          def validate_hash!(value)
            raise ArgumentError, "Expected a Hash, got #{value.class}" unless value.is_a?(Hash)
          end

          # Utility method to validate an Array.
          def validate_array!(value)
            raise ArgumentError, "Expected an Array, got #{value.class}" unless value.is_a?(Array)
          end

          # Utility method to validate a class instance.
          def validate_instance_of!(value, klass)
            raise ArgumentError, "Expected an instance of #{klass}, got #{value.class}" unless value.is_a?(klass)
          end
        end
      end
    end
  end
end
