# frozen_string_literal: true

require "pathname"
require_relative "renderer"

module DevSuite
  module DirectoryTree
    class Visualizer
      class << self
        # Visualizes the directory tree
        # @param base_path [String] The base path of the directory
        def visualize(base_path)
          new(base_path).visualize
        end
      end

      def initialize(base_path, renderer: Renderer::Simple.new(base_path))
        @renderer = renderer
      end

      def visualize
        puts @renderer.render
      end
    end
  end
end
