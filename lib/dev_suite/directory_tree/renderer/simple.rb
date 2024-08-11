# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Renderer
      class Simple < Base
        def render(node, prefix = "", is_last = true)
          return "" if skip_node?(node)

          is_root = prefix.empty?
          connector = choose_connector(is_root, is_last)
          new_prefix = calculate_new_prefix(prefix, is_last)

          output = format_node_output(node, prefix, connector)
          output += node_suffix(node)

          if node.directory? && node.children.any?
            node.children.each_with_index do |child, index|
              output += render(child, new_prefix, index == node.children.size - 1)
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

        def choose_connector(is_root, is_last)
          return "" if is_root

          is_last ? "└── " : "├── "
        end

        def calculate_new_prefix(prefix, is_last)
          "#{prefix}#{is_last ? "    " : "|   "}"
        end

        def format_node_output(node, prefix, connector)
          "#{prefix}#{connector}#{node.name}"
        end

        def node_suffix(node)
          node.directory? ? "/\n" : "\n"
        end
      end
    end
  end
end
