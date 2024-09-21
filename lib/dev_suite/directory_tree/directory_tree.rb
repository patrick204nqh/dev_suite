# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    require_relative "node"
    require_relative "config"
    require_relative "renderer"
    require_relative "builder"
    require_relative "visualizer"

    class << self
      def visualize(path)
        visualizer = Config.configuration.visualizer
        visualizer.visualize(path)
      end
    end
  end
end
