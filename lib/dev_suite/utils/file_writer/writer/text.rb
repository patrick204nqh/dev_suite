# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          # Updates a key-like pattern in a plain text file (find and replace)
          def update_key(key, value, backup: false)
            content = read

            # Simple pattern matching and replacement (e.g., `key: value`)
            updated_content = content.gsub(/^#{Regexp.escape(key)}:.*/, "#{key}: #{value}")

            write(updated_content, backup: backup)
          end
        end
      end
    end
  end
end
