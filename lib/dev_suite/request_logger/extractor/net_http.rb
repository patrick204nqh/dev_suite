# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class NetHttp < Base
        COMPONENT_KEY = ::Net::HTTP

        # Extracts the request details from a Net::HTTP request object
        # @param http [Net::HTTP] The Net::HTTP object that is making the request
        # @param request [Net::HTTP::Request] The request object that is being made
        def extract_request(http, request)
          Request.new(
            method: request.method,
            url: request.uri.to_s,
            headers: request.each_header.to_h,
            cookies: build_cookies(request),
            body: request.body,
          )
        end

        # Extracts the response details from a Net::HTTP response object
        # @param http [Net::HTTP] The Net::HTTP object that received the response
        # @param response [Net::HTTPResponse] The response object received
        # @return [Response] The extracted response details
        def extract_response(http, response)
          Response.new(
            status: response.code.to_i,
            message: response.message,
            headers: response.each_header.to_h,
            body: response.body,
            response_time: calculate_response_time(http),
          )
        end

        private

        # Builds the full URL for the request
        # @param http [Net::HTTP] The Net::HTTP object
        # @param request [Net::HTTP::Request] The request object
        # @return [String] The fully constructed URL
        def build_url(http, request)
          scheme = http.use_ssl? ? "https" : "http"
          host = http.address
          port = http.port
          path = request.path

          # Only include the port if it's non-standard
          default_port = (scheme == "https" ? 443 : 80)
          port_part = port == default_port ? nil : ":#{port}"

          "#{scheme}://#{host}#{port_part}#{path}"
        end

        # Extracts cookies from the request headers
        # @param request [Net::HTTP::Request] The request object
        # @return [Array<String>] Array of cookie strings
        def build_cookies(request)
          request.to_hash["cookie"] || []
        end

        # Calculates the response time (if available)
        # This example assumes response time is tracked separately and stored in the `http` object
        def calculate_response_time(http)
          if http.respond_to?(:start_time) && http.respond_to?(:end_time)
            http.end_time - http.start_time
          end
        end
      end
    end
  end
end
