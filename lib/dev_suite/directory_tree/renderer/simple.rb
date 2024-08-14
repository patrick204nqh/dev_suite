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
        INDENT = "    "
        PIPE = "│   "

        def render(node:, prefix: "", is_last: true, depth: 0)
          return "" if skip_node?(node) || exceeds_max_depth?(depth)

          output = node_line(node: node, prefix: prefix, is_last: is_last)
          if node.directory? && node.children.any?
            output += render_children(node: node, prefix: prefix, is_last: is_last, depth: depth)
          end

          output
        end

        private

        def settings
          Config.configuration.settings
        end

        def skip_node?(node)
          hidden_file_skipped?(node) || filetype_skipped?(node)
        end

        def hidden_file_skipped?(node)
          settings.get(:skip_hidden) && node.hidden?
        end

        def filetype_skipped?(node)
          node.file? && settings.get(:skip_types).include?(::File.extname(node.name))
        end

        def exceeds_max_depth?(depth)
          max_depth = settings.get(:max_depth)
          max_depth && depth > max_depth
        end

        def node_line(node:, prefix:, is_last:)
          connector = determine_connector(is_root: prefix.empty?, is_last: is_last)
          "#{prefix}#{connector}#{node.name}#{suffix_for(node)}"
        end

        def determine_connector(is_root:, is_last:)
          return "" if is_root

          is_last ? LAST_NODE_CONNECTOR : NODE_CONNECTOR
        end

        def suffix_for(node)
          node.directory? ? "/\n" : "\n"
        end

        def render_children(node:, prefix:, is_last:, depth:)
          new_prefix = updated_prefix(prefix: prefix, is_last: is_last)
          visible_children = node.children.reject { |child| skip_node?(child) }
          visible_children.each_with_index.map do |child, index|
            render(
              node: child,
              prefix: new_prefix,
              is_last: index == visible_children.size - 1,
              depth: depth + 1,
            )
          end.join
        end

        def updated_prefix(prefix:, is_last:)
          "#{prefix}#{is_last ? INDENT : PIPE}"
        end
      end
    end
  end
end
