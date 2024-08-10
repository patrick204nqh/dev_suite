# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        require_relative "palette/base"
        require_relative "palette/default"

        class << self
          def create(type)
            case type
            when :default
              Default.new
            else
              raise ArgumentError, "Unknown palette type: #{type}"
            end
          end
        end
      end
    end
  end
end
