# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Builder
      class Base
        #
        # Recursive method to build the tree
        #
        def build(path)
          return build_permission_denied_node(path) unless path.readable?

          path.directory? ? construct_directory_node(path) : build_file_node(path)
        rescue Errno::EACCES
          build_permission_denied_node(path)
        end

        protected

        def construct_directory_node(path)
          directory = Node::Directory.new(path.basename.to_s)
          path.children.each do |child|
            directory.add_child(build(child))
          end
          directory
        end

        def build_file_node(path)
          Node::File.new(path.basename.to_s)
        end

        def build_permission_denied_node(path)
          Node::PermissionDenied.new(path.basename.to_s, path.directory?)
        end
      end
    end
  end
end
