# frozen_string_literal: true

module ApiSharedExamples
  # Shared example for a successful API request
  RSpec.shared_examples("a successful request") do
    it "returns status 200" do
      expect(response).to(have_http_status_code(200))
    end

    it "returns JSON content" do
      expect(response.content_type).to(eq("application/json"))
    end
  end

  # Shared example for an unauthorized API request
  RSpec.shared_examples("an unauthorized request") do
    it "returns status 401" do
      expect(response).to(have_http_status_code(401))
    end
  end

  # Shared example for a not found API response
  RSpec.shared_examples("a not found response") do
    it "returns status 404" do
      expect(response).to(have_http_status_code(404))
    end
  end
end

RSpec.configure do |config|
  config.include(ApiSharedExamples)
end
