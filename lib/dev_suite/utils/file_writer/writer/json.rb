# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Json < Base
          def write(content, pretty: false, backup: false)
            create_backup(path) if backup

            json_content = convert_to_json(content, pretty)
            AtomicWriter.new(path, json_content).write
          end

          private

          def convert_to_json(content, pretty)
            pretty ? ::JSON.pretty_generate(content) : ::JSON.dump(content)
          end
        end
      end
    end
  end
end
