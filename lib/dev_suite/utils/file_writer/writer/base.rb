# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          # Abstract method that subclasses must implement for custom file write operations
          def write(_path, _content)
            raise NotImplementedError, "Subclasses must implement the `write` method"
          end

          # General method to update a key in any structured file
          def update_key(path, key, value, **options)
            # Step 1: Load the existing content of the file (this will be subclass-specific)
            content = load_file_content(path)

            # Step 2: Use a utility function to modify the content at the specified key path
            Utils::Data.set_value_by_path(content, key, value)

            # Step 3: Write the updated content back to the file using the subclass's write method
            write(path, content, **options)
          end

          private

          def file_exists?(path)
            ::File.exist?(path)
          end

          # Load the file content using a file loader
          def load_file_content(file_path)
            FileLoader.load(file_path)
          end

          def create_backup(path)
            BackupManager.new(path).create_backup if file_exists?(path)
          end
        end
      end
    end
  end
end
