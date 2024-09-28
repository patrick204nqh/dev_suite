# frozen_string_literal: true

module API
  module ResponseExamples
    # Shared example for an API response with dynamic status and body
    RSpec.shared_examples("an API response") do |status_code, expected_body = nil|
      it "returns a status of #{status_code}" do
        expect(response).to(have_http_status_code(status_code))
      end

      if expected_body
        it "returns the expected body" do
          expect(response).to(include_json(expected_body))
        end
      end
    end

    # Shared example for a successful API request
    RSpec.shared_examples("a successful request") do
      include_examples "an API response", 200

      it "returns JSON content" do
        expect(response.content_type).to(eq("application/json"))
      end
    end

    # Shared example for an unauthorized API request
    RSpec.shared_examples("an unauthorized request") do
      include_examples "an API response", 401
    end

    # Shared example for a not found API response
    RSpec.shared_examples("a not found response") do
      include_examples "an API response", 404
    end
  end
end

# Include the shared examples in RSpec configuration
RSpec.configure do |config|
  config.include(API::ResponseExamples, type: :request)
end
