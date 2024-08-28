# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class Faraday < Base
        COMPONENT_KEY = ::Faraday::Connection

        # Extracts the request details from a Faraday request object
        # @param _instance [Faraday::Connection] The instance of the Faraday client that is making the request
        # @param request [Faraday::Env] The request object that is being made
        def extract_request(connection, request)
          Request.new(
            method: request.method.to_s.upcase,
            url: build_url(connection),
            headers: build_headers_from_request(request),
            cookies: build_cookies(request),
            body: request.body,
          )
        end

        # Extracts the response details from a Faraday response object
        # @param _instance [Faraday::Connection] The instance of the Faraday client that received the response
        # @param response [Faraday::Env] The response object received
        def extract_response(_connection, response)
          Response.new(
            status: response.status,
            message: response.reason_phrase || "",
            headers: build_headers_from_response(response),
            body: response.body,
          )
        end

        private

        def build_url(connection)
          connection.url_prefix.to_s
        end

        def build_headers_from_request(request)
          request.request_headers.to_h
        end

        def build_headers_from_response(response)
          response.response_headers.to_h
        end

        def build_cookies(request)
          headers = build_headers_from_request(request)
          headers["Cookie"] ? [headers["Cookie"]] : []
        end
      end
    end
  end
end
