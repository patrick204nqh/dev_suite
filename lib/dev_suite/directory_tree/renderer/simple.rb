# frozen_string_literal: true

require_relative "base"
require_relative "../node"

module DevSuite
  module DirectoryTree
    module Renderer
      class Simple < Base
        private

        def build_tree(path)
          return permission_denied_node(path) unless path.readable?

          path.directory? ? directory_node(path) : file_node(path)
        rescue Errno::EACCES
          permission_denied_node(path)
        end

        def render_node(node, prefix = "", is_last = true)
          is_root = prefix.empty?
          connector = determine_connector(is_root, is_last)
          new_prefix = update_prefix(prefix, is_last)

          output = construct_output(node, prefix, connector)
          output += node_suffix(node)

          if node.directory? && node.children.any?
            node.children.each_with_index do |child, index|
              output += render_node(child, new_prefix, index == node.children.size - 1)
            end
          end

          output
        end

        def determine_connector(is_root, is_last)
          return "" if is_root

          is_last ? "└── " : "├── "
        end

        def update_prefix(prefix, is_last)
          "#{prefix}#{is_last ? "    " : "|   "}"
        end

        def construct_output(node, prefix, connector)
          "#{prefix}#{connector}#{node.name}"
        end

        def node_suffix(node)
          node.directory? ? "/\n" : "\n"
        end

        def directory_node(path)
          dir = Node::Directory.new(path.basename.to_s)
          sorted_children(path).each do |child|
            dir.add_child(build_tree(child))
          end
          dir
        end

        def file_node(path)
          Node::File.new(path.basename.to_s)
        end

        def permission_denied_node(path)
          Node::PermissionDenied.new(path.basename.to_s, path.directory?)
        end

        def sorted_children(path)
          path.children.sort_by { |child| child.basename.to_s.downcase }
        end
      end
    end
  end
end
