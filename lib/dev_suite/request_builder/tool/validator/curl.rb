# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      module Validator
        class Curl < Utils::Construct::Component::Validator::Base
          VALID_HTTP_METHODS = ["GET", "POST", "PUT", "DELETE", "PATCH", "HEAD", "OPTIONS"].freeze

          def validate!(http_method:, url:, headers:, body: nil)
            validate_http_method(http_method)
            validate_url(url)
            validate_headers(headers)
            validate_body(body)
          end

          private

          def validate_http_method(http_method)
            validate_inclusion!(http_method, VALID_HTTP_METHODS, field_name: "HTTP Method")
          end

          def validate_url(url)
            validate_url!(url, field_name: "URL")
          end

          def validate_headers(headers)
            validate_hash!(headers, field_name: "Headers")
          end

          def validate_body(body)
            validate_type!(body, [String, NilClass], field_name: "Body")
          end
        end
      end
    end
  end
end
