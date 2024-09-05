# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          def write(path, content)
            ensure_directory_exists(path)
            locked_write(path, content)
          end
        end
      end
    end
  end
end
