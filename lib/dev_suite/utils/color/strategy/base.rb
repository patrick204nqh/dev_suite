# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Strategy
        class Base < Utils::Construct::Component::Base
          def colorize(text, **kwargs)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
