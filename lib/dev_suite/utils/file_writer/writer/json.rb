# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Json < Base
          # Write a hash or array of hashes as JSON content to a file
          def write(path, content, pretty: false, create_backup: false)
            create_backup_if_needed(path, create_backup)
            json_content = convert_to_json(content, pretty)
            perform_atomic_write(path, json_content)
          rescue StandardError => e
            handle_write_error("JSON", path, e)
          end

          private

          # Convert content to JSON format
          def convert_to_json(content, pretty)
            pretty ? JSON.pretty_generate(content) : JSON.dump(content)
          end

          # Log and raise errors during the write process
          def handle_write_error(format, path, error)
            log_error("Error writing #{format} to #{path}: #{error.message}")
            raise
          end
        end
      end
    end
  end
end
