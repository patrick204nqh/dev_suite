# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      class Base
        def build_command(http_method:, url:, headers:, body: nil)
          raise NotImplementedError, "Subclasses must implement the `build_command` method"
        end
      end
    end
  end
end
