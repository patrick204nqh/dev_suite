# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Formatter
      # Formats a request as a GraphQL request.
      class GraphQL < Base
        class << self
          # Formats a request as a GraphQL request.
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
            formatted_body = format_body(body, data)
            formatted_headers = format_headers(headers, cookies)

            <<~GRAPHQL
              #{formatted_headers}
              #{formatted_body}
            GRAPHQL
          end

          private

          # Formats the body of the request.
          #
          # @param body [String, nil] the body of the request
          # @param data [Hash] additional data for the request
          # @return [String] the formatted body
          def format_body(body, data)
            return body if body

            formatted_data = data.map { |key, value| "#{key}: #{value}" }.join(", ")

            <<~GRAPHQL
              {
                #{formatted_data}
              }
            GRAPHQL
          end

          # Formats the headers of the request.
          #
          # @param headers [Hash] the headers for the request
          # @param cookies [Hash] the cookies for the request
          # @return [String] the formatted headers
          def format_headers(headers, cookies)
            formatted_headers = headers.map { |key, value| "#{key}: #{value}" }.join("\n")
            formatted_cookies = cookies.map { |key, value| "#{key}: #{value}" }.join("\n")

            <<~GRAPHQL
              headers: {
                #{formatted_headers}
              }
              cookies: {
                #{formatted_cookies}
              }
            GRAPHQL
          end
        end
      end
    end
  end
end
