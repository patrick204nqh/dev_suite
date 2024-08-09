# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Renderer
        class Base
          def initialize(config = Config.new)
            @config = config
          end

          def render(table)
            raise NotImplementedError, "Render method must be implemented in subclasses"
          end
        end
      end
    end
  end
end
