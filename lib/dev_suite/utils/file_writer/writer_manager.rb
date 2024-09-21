# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      class WriterManager
        def write(path, content)
          writer = writer_for(path)
          writer.write(path, content)
        end

        def update_key(path, key, value)
          writer = writer_for(path)
          writer.update_key(path, key, value)
        end

        private

        def writer_for(path)
          case ::File.extname(path)
          when ".json"
            Writer::Json.new
          when ".yml", ".yaml"
            Writer::Yaml.new
          else
            Writer::Text.new
          end
        end
      end
    end
  end
end
