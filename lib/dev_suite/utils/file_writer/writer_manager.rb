# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      class WriterManager
        def write(path, content)
          writer = writer_for(path)
          writer.write(content)
        end

        def update_key(path, key, value)
          writer = writer_for(path)
          writer.update_key(key, value)
        end

        private

        def writer_for(path)
          case ::File.extname(path)
          when ".json"
            Writer::Json.new(path)
          when ".yml", ".yaml"
            Writer::Yaml.new(path)
          else
            Writer::Text.new(path)
          end
        end
      end
    end
  end
end
