# frozen_string_literal: true

module DevSuite
  module CLI
    class Main < Thor
      desc "tree DIRECTORY", "Prints the directory tree"
      def tree(directory)
        execute_command(Commands::Tree, directory)
      end

      desc "version", "Displays the version of the dev_suite gem"
      def version
        execute_command(Commands::Version)
      end

      private

      def execute_command(command_class, *args)
        command_class.new.execute(*args)
      rescue StandardError => e
        handle_error(e)
      end

      def handle_error(error)
        puts "An error occurred: #{error.message}"
      end
    end
  end
end
