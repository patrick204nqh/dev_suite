# frozen_string_literal: true

# request_logger/request.rb

module DevSuite
  module RequestLogger
    class Request
      include Utils::WarningHandler

      attr_reader :method, :url, :headers, :cookies, :body

      def initialize(method:, url:, headers:, cookies:, body:)
        @method = method
        @url = url
        @headers = headers
        @cookies = cookies
        @body = body

        validate_presence
      end

      private

      def validate_presence
        warn_if_missing("Request URL", @url)
        warn_if_missing("Request Method", @method)
        warn_if_missing("Request Headers", @headers)
      end
    end
  end
end
