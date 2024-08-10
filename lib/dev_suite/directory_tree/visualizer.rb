# frozen_string_literal: true

require "pathname"

module DevSuite
  module DirectoryTree
    class Visualizer
      attr_reader :config

      def initialize(config = Config.configuration)
        @config = config
      end

      # Visualizes the directory tree
      # @param path [String] The base path of the directory
      def visualize(path)
        puts @config.renderer.render(path)
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
