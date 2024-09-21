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
            content = ::File.read(path)
            return {} if content.strip.empty?

            ::JSON.parse(content)
          end
        end
      end
    end
  end
end
