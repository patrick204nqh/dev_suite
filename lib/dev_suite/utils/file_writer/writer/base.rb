# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          def write(_path, _content)
            raise NotImplementedError, "Subclasses must implement the `write` method"
          end
        end
      end
    end
  end
end
