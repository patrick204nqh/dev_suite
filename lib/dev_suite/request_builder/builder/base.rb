# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Builder
      class Base
        attr_reader :url, :headers, :tool

        def initialize(url:, headers: {}, tool:)
          @url = url
          @headers = headers
          @tool = tool
        end

        def build_command
          raise NotImplementedError, "Subclasses must implement the `build_command` method"
        end

        protected

        def format_headers
          headers.map { |key, value| "#{key}: #{value}" }.join("\n")
        end
      end
    end
  end
end
