# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        class Json < Base
          class << self
            def extensions
              ["json"]
            end
          end

          def load(path)
            ::JSON.parse(::File.read(path))
          end
        end
      end
    end
  end
end
