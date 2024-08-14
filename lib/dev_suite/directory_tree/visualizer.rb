# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      require "pathname"

      require_relative "visualizer/base"
      require_relative "visualizer/tree"

      class << self
        def create(type)
          case type
          when :tree
            Tree.new
          else
            raise ArgumentError, "Unknown renderer type: #{type}"
          end
        end
      end
    end
  end
end
