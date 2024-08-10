# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        require_relative "renderer/base"
        require_relative "renderer/simple"

        class << self
          def create(type, setting: {})
            case type
            when :simple
              Simple.new(setting)
            else
              raise ArgumentError, "Unknown renderer type: #{type}"
            end
          end
        end
      end
    end
  end
end
