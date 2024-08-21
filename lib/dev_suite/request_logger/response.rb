# frozen_string_literal: true

# request_logger/response.rb

module DevSuite
  module RequestLogger
    class Response
      attr_reader :status, :message, :headers, :body

      def initialize(status:, message:, headers:, body:)
        @status = status.to_i # Ensure status is always an integer
        @message = message
        @headers = headers || {} # Default to an empty hash if headers are nil
        @body = body || "" # Default to an empty string if body is nil
      end

      # Check if the response is successful (2xx status codes)
      def success?
        status.between?(200, 299)
      end

      # Helper method to fetch specific headers in a case-insensitive way
      def header(key)
        headers[key.to_s.downcase] || headers[key.to_s]
      end
    end
  end
end
