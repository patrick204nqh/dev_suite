# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        class Base
          def colorize(text, **kwargs)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
