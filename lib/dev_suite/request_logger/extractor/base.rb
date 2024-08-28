# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      class Base < Utils::Construct::Component::Base
        # Extracts the request details from an HTTP request object
        # @param instance [Object] The instance of the HTTP client that is making the request
        # @param request [Object] The request object that is being made
        def extract_request(_instance, _request)
          raise NotImplementedError
        end

        # Extracts the response details from an HTTP response object
        # @param instance [Object] The instance of the HTTP client that is making the request
        # @param response [Object] The response object that is being returned
        def extract_response(_instance, _response)
          raise NotImplementedError
        end
      end
    end
  end
end
