# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Visualizer
      # Visualizes the directory tree
      # @param path [String] The base path of the directory
      def visualize(path)
        root = Config.configuration.builder.build(Pathname.new(path))
        puts Config.configuration.renderer.render(root)
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
