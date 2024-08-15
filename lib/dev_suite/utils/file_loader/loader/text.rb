module DevSuite
  module Utils
    module FileLoader
      module Loader
        class Text < Base
          class << self
            def extensions
              ['txt']
            end

          end

          def load(path)
            ::File.read(path)
          end
        end
      end
    end
  end
end