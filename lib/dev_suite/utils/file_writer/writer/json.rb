# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Json < Base
          def write(path, content)
            ::File.write(path, content.to_json)
          end
        end
      end
    end
  end
end
