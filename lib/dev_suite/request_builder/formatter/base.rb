# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Formatter
      class Base
        def format_body(body)
          raise NotImplementedError, "Subclasses must implement the `format_body` method"
        end
      end
    end
  end
end
