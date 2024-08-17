# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      require_relative "reporter/base"
      require_relative "reporter/simple"
      require_relative "reporter/helpers"

      class << self
        def create(reporter)
          case reporter
          when :simple
            Simple.new
          else
            raise ArgumentError, "Invalid reporter: #{reporter}"
          end
        end
      end
    end
  end
end
