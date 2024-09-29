# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          attr_reader :path

          def initialize(path)
            super()
            @path = path
          end

          def read
            FileLoader.load(path)
          end

          def write(content, backup: false)
            create_backup if backup
            AtomicWriter.new(path, content).write
          end

          def append(content)
            current_content = read
            updated_content = current_content.merge(content)
            write(updated_content)
          end

          def delete_lines(start_line, end_line = start_line)
            lines = ::File.readlines(path)
            lines.slice!(start_line - 1, end_line - start_line + 1)
            write(lines.join)
          end

          def update_key(key, value, **options)
            content = read
            Utils::Data.set_value_by_path(content, key, value)
            write(content, **options)
          end

          def delete_key(key, **options)
            content = read
            Utils::Data.delete_key_by_path(content, key)
            write(content, **options)
          end

          def append_array(array_key, new_elements)
            data = read
            data[array_key] ||= []
            data[array_key].concat(new_elements)
            write(data)
          end

          private

          def file_exists?(path)
            ::File.exist?(path)
          end

          def create_backup(path)
            BackupManager.new(path).create_backup if file_exists?(path)
          end
        end
      end
    end
  end
end
