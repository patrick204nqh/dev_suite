# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Json < Base
          # Write a hash or array of hashes as JSON content to a file
          def write(path, content, pretty: false, create_backup: false)
            # Step 1: Create a backup of the file if it exists and backup option is enabled
            create_backup(path) if create_backup && file_exists?(path)

            # Step 2: Convert the content to JSON format
            json_content = pretty ? JSON.pretty_generate(content) : JSON.dump(content)

            # Step 3: Perform atomic write
            atomic_write(path, json_content)
          rescue StandardError => e
            log_error("Error writing JSON to #{path}: #{e.message}")
            raise
          else
            log_info("Successfully wrote JSON content to #{path}")
          end

          private

          # Creates a backup of the existing file before overwriting it
          def create_backup(path)
            backup_path = "#{path}.bak"
            log_info("Creating backup of #{path} at #{backup_path}")
            ::FileUtils.cp(path, backup_path)
          rescue IOError => e
            log_error("Failed to create backup for #{path}: #{e.message}")
            raise
          end

          # Logs successful operations
          def log_info(message)
            puts "[Info] #{message}"
          end
        end
      end
    end
  end
end
