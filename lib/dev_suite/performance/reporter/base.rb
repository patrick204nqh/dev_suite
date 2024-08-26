# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      class Base < Utils::Construct::Component::Base
        def generate
          raise NotImplementedError, "Subclasses must implement the generate method"
        end
      end
    end
  end
end
