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

          def update_key(path, key, value)
            writer_instance(path).update_key(key, value)
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
