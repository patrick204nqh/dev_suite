# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class Faraday < Base
        COMPONENT_KEY = ::Faraday::Middleware

        def extract_request(native_request)
          Request.new(
            method: native_request.method.to_s.upcase,
            url: native_request.url.to_s,
            headers: native_request.request_headers.to_h,
            cookies: extract_cookies(native_request.request_headers),
            body: native_request.body,
          )
        end

        def extract_response(native_response)
          Response.new(
            status: native_response.status,
            message: native_response.reason_phrase || "",
            headers: native_response.response_headers.to_h,
            body: native_response.body,
          )
        end

        private

        def extract_cookies(headers)
          headers = headers.to_h
          headers["Cookie"] ? [headers["Cookie"]] : []
        end
      end
    end
  end
end
