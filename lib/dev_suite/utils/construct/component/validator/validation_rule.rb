# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Validator
          module ValidationRule
            def validate_inclusion!(value, allowed_values, field_name: "Value")
              unless allowed_values.include?(value)
                raise_validation_error(
                  field_name,
                  "#{value} is not valid. Allowed values: #{allowed_values.join(", ")}",
                )
              end
            end

            def validate_non_empty_string!(value, field_name: "Value")
              unless value.is_a?(String) && !value.strip.empty?
                raise_validation_error(field_name, "must be a non-empty string.")
              end
            end

            def validate_url!(url, field_name: "URL")
              unless url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(["http", "https"])}\z/
                raise_validation_error(field_name, "#{url} is not a valid URL.")
              end
            end

            def validate_hash!(value, field_name: "Value")
              unless value.is_a?(Hash)
                raise_validation_error(field_name, "must be a Hash. Provided value is #{value.class.name}.")
              end
            end

            def validate_array_of_type!(array, klass, field_name: "Array")
              unless array.is_a?(Array) && array.all? { |item| item.is_a?(klass) }
                raise_validation_error(field_name, "must be an Array of #{klass.name} instances.")
              end
            end

            def validate_range!(value, range, field_name: "Value")
              unless range.include?(value)
                raise_validation_error(field_name, "#{value} is not within the allowed range: #{range}.")
              end
            end

            def validate_presence!(value, field_name: "Value")
              if value.nil? || (value.respond_to?(:empty?) && value.empty?)
                raise_validation_error(field_name, "is required and cannot be empty.")
              end
            end

            def validate_type!(value, allowed_types, field_name: "Value")
              return if allowed_types.any? { |type| value.is_a?(type) }

              allowed_names = allowed_types.map(&:name).join(", ")
              raise_validation_error(
                field_name,
                "must be one of the following types: #{allowed_names}. Got #{value.class.name} instead.",
              )
            end
          end
        end
      end
    end
  end
end
