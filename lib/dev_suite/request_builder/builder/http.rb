# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Builder
      class Http < Base
        attr_reader :http_method, :body

        def initialize(url:, http_method: "GET", headers: {}, body: nil, tool:)
          super(url: url, headers: headers, tool: tool)
          @http_method = http_method.upcase
          @body = body
        end

        def build_command
          case tool
          when :curl
            Tool::Curl.new.build_command(http_method: http_method, url: url, headers: headers, body: format_body(body))
          else
            raise ArgumentError, "Unknown tool: #{tool}"
          end
        end

        private

        def format_body(body)
          Formatter::Graphql.new.format_body(body)
        end
      end
    end
  end
end
