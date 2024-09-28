# frozen_string_literal: true

module API
  module HaveHttpStatusCodeMatcher
    RSpec::Matchers.define(:have_http_status_code) do |expected_code|
      match do |response|
        response.status == expected_code
      end

      failure_message do |response|
        "expected HTTP status #{expected_code}, but got #{response.status}"
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
