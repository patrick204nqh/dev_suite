# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Visualizer
      class Tree < Base
        # Visualizes the directory tree
        # @param path [String] The base path of the directory
        def visualize(path)
          path = Pathname.new(path)
          validate_path!(path)
          validate_size!(path)

          root = build_root_node(path)
          output = render_output(root)

          puts output
        end

        private

        def validate_path!(path)
          raise ArgumentError, "Invalid path" unless path.exist?
        end

        def validate_size!(path)
          config = Config.configuration
          max_size = config.settings.get(:max_size)
          raise ArgumentError, "Directory too large to render" if directory_size(path) > max_size
        end

        def directory_size(path)
          path.children.reduce(0) do |size, child|
            size + (child.directory? ? directory_size(child) : child.size)
          end
        end

        def build_root_node(path)
          config = Config.configuration
          config.builder.build(path)
        end

        def render_output(root)
          config = Config.configuration
          config.renderer.render(node: root)
        end
      end
    end
  end
end
