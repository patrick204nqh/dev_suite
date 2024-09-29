# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      class UnsupportedFileTypeError < StandardError; end

      class WriterManager
        WRITERS = {
          ".json" => Writer::Json,
          ".yml" => Writer::Yaml,
          ".yaml" => Writer::Yaml,
          ".txt" => Writer::Text,
        }.freeze

        class << self
          def write(path, content)
            writer_instance(path).write(content)
          end

          def append(path, content)
            writer_instance(path).append(content)
          end

          def delete_lines(path, start_line, end_line = start_line)
            writer_instance(path).delete_lines(start_line, end_line)
          end

          def update_key(path, key, value)
            writer_instance(path).update_key(key, value)
          end

          def delete_key(path, key)
            writer_instance(path).delete_key(key)
          end

          private

          # Returns the appropriate writer instance based on the file extension
          def writer_instance(path)
            writer_class = WRITERS[file_extension(path)]
            raise UnsupportedFileTypeError, "Unsupported file type: #{file_extension(path)}" unless writer_class

            writer_class.new(path)
          end

          # Returns the file extension from the path
          def file_extension(path)
            ::File.extname(path).downcase
          end
        end
      end
    end
  end
end
