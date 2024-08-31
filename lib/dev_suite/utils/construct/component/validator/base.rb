# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Validator
          class Base
            include ValidationRule

            def validate!(**args)
              raise NotImplementedError
            end

            protected

            def raise_validation_error(field, message)
              raise ValidationError.new(field, message)
            end
          end
        end
      end
    end
  end
end
