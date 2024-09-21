# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          def write(path, content, backup: false)
            create_backup(path) if backup

            AtomicWriter.new(path, content).write
          end

          # Updates a key-like pattern in a plain text file (find and replace)
          def update_key(path, key, value, backup: false)
            content = load_file_content(path)

            # Simple pattern matching and replacement (e.g., `key: value`)
            updated_content = content.gsub(/^#{Regexp.escape(key)}:.*/, "#{key}: #{value}")

            write(path, updated_content, backup: backup)
          end
        end
      end
    end
  end
end
