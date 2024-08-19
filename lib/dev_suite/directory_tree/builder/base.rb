# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Builder
      class Base
        #
        # Recursive method to build the tree
        #
        def build(path)
          return build_permission_denied_node(path) unless readable?(path)

          build_node(path)
        rescue Errno::EACCES
          build_permission_denied_node(path)
        end

        protected

        def build_node(path)
          if path.directory?
            construct_directory_node(path)
          else
            build_file_node(path)
          end
        end

        def construct_directory_node(path)
          directory_node = Node::Directory.new(path.basename.to_s)
          
          # Gather valid children nodes
          valid_children = path.children.each_with_object([]) do |child, arr|
            child_node = build(child)
            arr << child_node if child_node
          end

          # Only add children if there are any valid ones
          valid_children.each { |child_node| directory_node.add_child(child_node) }

          # Include directory if it has valid children or matches patterns
          if valid_children.any? || directory_should_be_included?(path)
            return directory_node
          end

          nil
        end

        def build_file_node(path)
          Node::File.new(path.basename.to_s)
        end

        def build_permission_denied_node(path)
          Node::PermissionDenied.new(path.basename.to_s, path.directory?)
        end

        private

        def settings
          Config.configuration.settings
        end

        def directory_should_be_included?(path)
          # Exclude takes priority over include
          return false if excluded_by_pattern?(path)
          return true if included_by_pattern?(path)
          false
        end

        def valid_path?(path)
          # Check if it's excluded
          return false if excluded_by_pattern?(path)
          # Check if it matches include patterns (if any)
          return false unless included_by_pattern?(path)

          # Further checks
          return false unless readable?(path)
          return false if hidden_file?(path) && skip_hidden?
          return false if skip_type?(path)

          true
        end

        def included_by_pattern?(path)
          includes = settings.get(:includes)
          return true if includes.nil? || includes.empty? # Default to including everything if no includes specified
          Utils::PathMatcher.match?(path, includes: includes)
        end

        def excluded_by_pattern?(path)
          excludes = settings.get(:excludes)
          return false if excludes.nil? || excludes.empty? # Default to not excluding anything if no excludes specified
          Utils::PathMatcher.match?(path, excludes: excludes)
        end

        def hidden_file?(path)
          path.basename.to_s.start_with?(".")
        end

        def skip_hidden?
          settings.get(:skip_hidden)
        end

        def skip_type?(path)
          settings.get(:skip_types).include?(path.extname)
        end

        def readable?(path)
          path.readable?
        end
      end
    end
  end
end
