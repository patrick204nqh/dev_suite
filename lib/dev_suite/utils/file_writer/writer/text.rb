# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          def write(path, content)
            dir = ::File.dirname(path)
            ::Dir.mkdir(dir) unless ::Dir.exist?(dir)
            ::File.write(path, content)
          end
        end
      end
    end
  end
end
