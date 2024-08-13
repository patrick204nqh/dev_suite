# frozen_string_literal: true

module DevSuite
  module CLI
    module Commands
      class Base < Thor
        no_commands do
          # Log message to console
          def log(message, level: :info)
            case level
            when :info
              puts "[INFO] #{message}"
            when :warn
              puts "[WARNING] #{message}"
            when :error
              puts "[ERROR] #{message}"
            when :debug
              puts "[DEBUG] #{message}" if ENV["DEBUG_MODE"]
            else
              raise ArgumentError, "Invalid log level: #{level}"
            end
          end

          # Handle common errors
          def handle_error(error)
            log("Error: #{error.message}", level: :error)
            exit(1)
          end

          # Default method to load configuration
          def load_config(file)
            YAML.load_file(file)
          rescue Errno::ENOENT
            log("Configuration file not found: #{file}", level: :error)
            exit(1)
          end
        end

        desc "execute", "Execute the command"
        def execute
          raise NotImplementedError
        end
      end
    end
  end
end
