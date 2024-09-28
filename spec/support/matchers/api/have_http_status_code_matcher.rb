# frozen_string_literal: true

require "net/http"

module API
  module HaveHttpStatusCodeMatcher
    RSpec::Matchers.define(:have_http_status_code) do |expected_code|
      match do |response|
        raise ArgumentError, "response must be an Net::HTTPResponse object" unless response.is_a?(Net::HTTPResponse)

        response.code.to_i == expected_code
      end

      failure_message do |response|
        "expected HTTP status #{expected_code}, but got #{response.code.to_i}"
      end

      description do
        "have HTTP status code #{expected_code}"
      end
    end
  end
end

RSpec.configure do |config|
  config.include(API::HaveHttpStatusCodeMatcher, type: :request)
end
