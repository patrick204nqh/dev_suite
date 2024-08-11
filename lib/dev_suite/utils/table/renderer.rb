# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        require_relative "renderer/base"
        require_relative "renderer/simple"

        class << self
          def create(type, settings: Settings.new)
            case type
            when :simple
              Simple.new(settings: settings)
            else
              raise ArgumentError, "Unknown renderer type: #{type}"
            end
          end
        end
      end
    end
  end
end
