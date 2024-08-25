# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class NetHttp < Base
        COMPONENT_KEY = ::Net::HTTP

        def extract_request(native_request)
          Request.new(
            method: native_request.method,
            url: native_request.uri.to_s,
            headers: native_request.each_header.to_h,
            cookies: extract_cookies(native_request),
            body: native_request.body,
          )
        end

        def extract_response(native_response)
          Response.new(
            status: native_response.code.to_i,
            message: native_response.message,
            headers: native_response.each_header.to_h,
            body: native_response.body,
          )
        end

        private

        def extract_cookies(request)
          request.to_hash["cookie"] || []
        end
      end
    end
  end
end
