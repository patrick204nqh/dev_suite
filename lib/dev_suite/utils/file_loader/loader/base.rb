# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        class Base < Structure::Component
          class << self
            def extensions
              raise NotImplementedError, "You must implement the extensions method"
            end
          end

          def load(_path)
            raise NotImplementedError, "You must implement the load method"
          end
        end
      end
    end
  end
end
