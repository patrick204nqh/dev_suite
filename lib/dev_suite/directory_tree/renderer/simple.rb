# frozen_string_literal: true

require_relative "base"
require_relative "../node"

module DevSuite
  module DirectoryTree
    module Renderer
      class Simple < Base
        private

        def build_tree(path)
          return Node::PermissionDenied.new(path.basename.to_s, path.directory?) unless path.readable?

          if path.directory?
            dir = Node::Directory.new(path.basename.to_s)
            children = path.children.sort_by { |child| child.basename.to_s.downcase }
            children.each do |child|
              dir.add_child(build_tree(child))
            end
            dir
          else
            Node::File.new(path.basename.to_s)
          end
        rescue Errno::EACCES
          Node::PermissionDenied.new(path.basename.to_s, path.directory?)
        end

        def render_node(node, prefix = "", is_last = true)
          # Determine if this is the root node based on the prefix content
          is_root = prefix.empty?

          # Prepare the connector appropriately, omitting it for the root
          connector = if is_root
            ""
          else
            (is_last ? "└── " : "├── ")
          end

          # Compute the new prefix for children
          new_prefix = "#{prefix}#{is_last ? "    " : "|   "}"

          # Construct the output for the current node, avoiding the connector for the root
          output = "#{prefix}#{connector}#{node.name}"
          output += "/\n" if node.directory?

          # Recursively render children if it's a directory
          if node.directory? && node.children.any?
            node.children.each_with_index do |child, index|
              output += render_node(child, new_prefix, index == node.children.size - 1)
            end
          elsif !node.directory?
            output += "\n"
          end

          output
        end
      end
    end
  end
end
