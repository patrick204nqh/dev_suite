# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Generator
      # Generates a request using cURL.
      class Curl < Base
        class << self
          # Generates a request using cURL.
          #
          # @param url [String] the URL for the request
          # @param method [Symbol] the HTTP method for the request
          # @param headers [Hash] the headers for the request
          # @param cookies [Hash] the cookies for the request
          # @param body [String, nil] the body of the request
          # @return [String] the generated request
          def generate_request(url:, method:, headers:, cookies:, body:)
            formatted_headers = format_headers(headers)
            formatted_cookies = format_cookies(cookies)
            formatted_body = format_body(body)
            formatted_method = method.to_s.upcase

            <<~CURL
              curl -X "#{formatted_method}" \\
              #{formatted_headers} \\
              #{formatted_cookies} \\
              -d '#{formatted_body}' \\
              "#{url}"
            CURL
          end

          private

          # Formats the body of the request.
          #
          # @param body [String, nil] the body of the request
          # @return [String] the formatted body
          def format_body(body)
            return body if body

            <<~BODY
              {
                "query": "query { hello }"
              }
            BODY
          end

          # Formats the headers of the request.
          #
          # @param headers [Hash] the headers for the request
          # @return [String] the formatted headers
          def format_headers(headers)
            headers.map { |key, value| "-H \"#{key}: #{value}\"" }.join(" \\\n")
          end

          # Formats the cookies of the request.
          #
          # @param cookies [Hash] the cookies for the request
          # @return [String] the formatted cookies
          def format_cookies(cookies)
            return "" if cookies.empty?

            formatted_cookies = cookies.map { |key, value| "#{key}=#{value}" }.join("; ")
            "-H \"Cookie: #{formatted_cookies}\""
          end
        end
      end
    end
  end
end
