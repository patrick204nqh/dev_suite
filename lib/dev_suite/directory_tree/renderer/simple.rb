# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      class Simple < Base
        # The characters are used to draw the tree structure
        #
        # └ (U+2514) is the L-shaped corner character
        # ├ (U+251C) is the L-shaped corner character
        # │ (U+2502) is the vertical line character
        # ─ (U+2500) is the horizontal line character
        #   (U+00A0) is the non-breaking space character
        # | (U+007C) is the vertical line character
        #   (U+0020) is the space character
        LAST_NODE_CONNECTOR = "└── "
        NODE_CONNECTOR = "├── "
        SPACE = "    "
        VERTICAL_LINE = "│   "

        def render(node, prefix = "", is_last = true)
          return "" if skip_node?(node)

          is_root = prefix.empty?
          connector = choose_connector(is_root, is_last)
          new_prefix = calculate_new_prefix(prefix, is_last)

          output = format_node_output(node, prefix, connector)
          output += node_suffix(node)

          if node.directory? && node.children.any?
            visible_children = node.children.reject { |child| skip_node?(child) }
            visible_children.each_with_index do |child, index|
              output += render(child, new_prefix, index == visible_children.size - 1)
            end
          end

          output
        end

        private

        def skip_node?(node)
          return true if Config.configuration.settings.skip_hidden? && node.hidden?
          return true if node.file? && Config.configuration.settings.skip_types.include?(::File.extname(node.name))

          false
        end

        def build_node_output(node, prefix, is_last)
          connector = choose_connector(prefix.empty?, is_last)
          format_node_output(node, prefix, connector) + node_suffix(node)
        end

        def choose_connector(is_root, is_last)
          return "" if is_root

          is_last ? LAST_NODE_CONNECTOR : NODE_CONNECTOR
        end

        def calculate_new_prefix(prefix, is_last)
          "#{prefix}#{is_last ? SPACE : VERTICAL_LINE}" # (U+2502)
        end

        def format_node_output(node, prefix, connector)
          [
            prefix,
            connector,
            node.name,
          ].join
        end

        def node_suffix(node)
          node.directory? ? "/\n" : "\n"
        end
      end
    end
  end
end
