# frozen_string_literal: true

module DevSuite
  module RequestLogger
    class Response
      include Utils::WarningHandler

      attr_reader :status, :message, :headers, :body, :content_type, :content_length, :response_time

      def initialize(
        status:,
        message:,
        headers:,
        body:,
        response_time: nil
      )
        @status = status.to_i
        @message = message
        @headers = headers
        @body = body
        @content_type = extract_content_type
        @content_length = extract_content_length
        @response_time = response_time

        validate_presence
      end

      def success?
        status.between?(200, 299)
      end

      def header(key)
        headers[key.to_s.downcase] || headers[key.to_s]
      end

      private

      def extract_content_type
        header("Content-Type") || "unknown"
      end

      def extract_content_length
        length = header("Content-Length")
        length ? length.to_i : 0
      end

      def validate_presence
        warn_if_missing("Response Status", @status)
        warn_if_missing("Response Headers", @headers)
      end
    end
  end
end
