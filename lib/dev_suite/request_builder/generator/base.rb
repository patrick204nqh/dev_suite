# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Generator
      # Base class for request
      class Base
        class << self
          # Generates a request.
          #
          # @param url [String] the URL for the request
          # @param headers [Hash] the headers for the request
          # @param cookies [Hash] the cookies for the request
          # @param body [String, nil] the body of the request
          # @return [Object] the generated request
          def generate_request(url:, method:, headers:, cookies:, body:)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
