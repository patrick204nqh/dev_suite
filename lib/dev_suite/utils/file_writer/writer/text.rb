# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Text < Base
          def write(path, content)
            perform_atomic_write(path, content)
          end
        end
      end
    end
  end
end
