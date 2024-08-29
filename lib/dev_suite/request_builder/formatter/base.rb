# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Formatter
      # Base class for formatters.
      class Base
        class << self
          # Formats a request.
          #
          # @param method [Symbol] the HTTP method for the request
          # @param url [String] the URL for the request
          # @param headers [Hash] the headers for the request
          # @param cookies [Hash] the cookies for the request
          # @param params [Hash] the parameters for the request
          # @param body [String, nil] the body of the request
          # @param data [Hash] additional data for the request
          # @param options [Hash] additional options for the request
          # @return [String] the formatted request
          def format_request(
            method:,
            url:,
            headers: {},
            cookies: {},
            params: {},
            body: nil,
            data: {},
            options: {}
          )
            raise NotImplementedError
          end

          private

          # Formats the headers of the request.
          #
          # @param headers [Hash] the headers for the request
          # @param cookies [Hash] the cookies for the request
          # @return [String] the formatted headers
          def format_headers(headers, cookies)
            formatted_headers = headers.map { |key, value| "#{key}: #{value}" }.join("\n")
            formatted_cookies = cookies.map { |key, value| "#{key}=#{value}" }.join("; ")

            <<~HEADERS
              #{formatted_headers}
              Cookie: #{formatted_cookies}
            HEADERS
          end
        end
      end
    end
  end
end
