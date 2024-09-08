# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          # Ensure the text content is written as plain text without extra quotes
          def write(path, content, create_backup: false)
            # Step 1: Create a backup if required
            create_backup(path) if create_backup && file_exists?(path)

            # Step 2: Perform atomic write
            atomic_write(path, content) # Write content directly without serialization
          rescue StandardError => e
            log_error("Error writing text to #{path}: #{e.message}")
            raise
          else
            log_info("Successfully wrote text content to #{path}")
          end
        end
      end
    end
  end
end
