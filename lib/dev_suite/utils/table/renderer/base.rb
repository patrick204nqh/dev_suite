# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        class Base < Structure::Component
          def render(table)
            raise NotImplementedError, "Render method must be implemented in subclasses"
          end
        end
      end
    end
  end
end
