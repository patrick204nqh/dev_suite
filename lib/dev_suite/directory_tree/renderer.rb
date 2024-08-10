# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      require_relative "renderer/base"
      require_relative "renderer/simple"

      class << self
        def create(type)
          case type
          when :simple
            Simple.new
          else
            raise ArgumentError, "Unknown renderer type: #{type}"
          end
        end
      end
    end
  end
end
