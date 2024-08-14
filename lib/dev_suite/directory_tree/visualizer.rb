# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Visualizer
      def initialize
        @config = Config.configuration
      end

      # Visualizes the directory tree
      # @param path [String] The base path of the directory
      def visualize(path)
        root = @config.builder.build(Pathname.new(path))
        output = @config.renderer.render(node: root)
        puts output
      end
    end

    class << self
      def visualize(path)
        visualizer = Visualizer.new
        visualizer.visualize(path)
      end
    end
  end
end
