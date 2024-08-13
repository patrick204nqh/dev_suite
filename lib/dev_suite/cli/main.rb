# frozen_string_literal: true

module DevSuite
  module CLI
    class Main < Thor
      desc "tree DIRECTORY", "Prints the directory tree"
      method_option :depth, aliases: "-d", type: :numeric, desc: "Limit the depth of the directory tree displayed"
      method_option :skip_hidden, type: :boolean, default: false, desc: "Skip hidden files and directories"
      method_option :skip_types,
        type: :array,
        default: [],
        banner: "TYPE1 TYPE2",
        desc: "Exclude files of specific types"
      def tree(path = ".")
        execute_command(Commands::Tree, path, options: options)
      end

      desc "version", "Displays the version of the dev_suite gem"
      def version
        execute_command(Commands::Version)
      end

      private

      def execute_command(command_class, *args, **kargs)
        command_class.new.execute(*args, **kargs)
      rescue StandardError => e
        handle_error(e)
      end

      def handle_error(error)
        puts "An error occurred: #{error.message}"
      end
    end
  end
end
