# frozen_string_literal: true

# request_logger/request.rb

module DevSuite
  module RequestLogger
    class Request
      attr_reader :method, :url, :headers, :cookies, :body

      def initialize(method:, url:, headers:, cookies:, body:)
        @method = method
        @url = url
        @headers = headers
        @cookies = cookies
        @body = body
      end
    end
  end
end
