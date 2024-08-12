# frozen_string_literal: true

module DevSuite
  module Performance
    module Reportor
      require_relative "reportor/base"
      require_relative "reportor/simple"
      require_relative "reportor/helpers"

      class << self
        def create(reportor)
          case reportor
          when :simple
            Simple.new
          else
            raise ArgumentError, "Invalid reportor: #{reportor}"
          end
        end
      end
    end
  end
end
