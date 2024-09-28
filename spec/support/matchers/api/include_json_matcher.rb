# frozen_string_literal: true

module API
  module IncludeJson
    RSpec::Matchers.define(:include_json) do |expected_hash|
      match do |response|
        json = JSON.parse(response.body, symbolize_names: true)
        expected_hash.all? { |key, value| json[key] == value }
      end

      failure_message do |response|
        "expected JSON response to include #{expected_hash}, but got #{response.body}"
      end

      description do
        "include JSON key-value pairs: #{expected_hash}"
      end
    end
  end
end

RSpec.configure do |config|
  config.include(API::IncludeJson, type: :request)
end
