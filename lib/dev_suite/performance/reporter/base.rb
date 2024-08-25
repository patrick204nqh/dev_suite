# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      class Base < Structure::Component
        def generate
          raise NotImplementedError, "Subclasses must implement the generate method"
        end
      end
    end
  end
end
