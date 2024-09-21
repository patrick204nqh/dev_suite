# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Validator
          class ValidationError < StandardError
            attr_reader :field, :message

            def initialize(field, message)
              @field = field
              @message = message
              super("[#{field}] #{message}")
            end
          end
        end
      end
    end
  end
end
