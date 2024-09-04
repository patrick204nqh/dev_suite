# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Yaml < Base
          def write(path, content)
            ::File.write(path, content.to_yaml)
          end
        end
      end
    end
  end
end
