# frozen_string_literal: true

require "spec_helper"

RSpec.describe("API Support", type: :request) do
  let(:url) { "https://jsonplaceholder.typicode.com/todos/1" }
  let(:response_body) { '{"name": "John", "age": 30}' }

  # Stub the external HTTP request with WebMock before each test
  before do
    stub_request(:get, url)
      .to_return(status: 200, body: response_body, headers: { "Content-Type" => "application/json" })
  end

  # -------------------------------
  # 1. Testing Custom Matchers
  # -------------------------------
  describe "Custom Matchers" do
    it "validates have_http_status_code matcher" do
      get_json(url)
      expect(response).to(have_http_status_code(200))
      expect(response).not_to(have_http_status_code(404))
    end

    it "validates include_json matcher" do
      get_json(url)
      expect(response).to(include_json(name: "John"))
      expect(response).not_to(include_json(name: "Doe"))
    end
  end

  # -------------------------------
  # 2. Testing Shared Examples
  # -------------------------------
  describe "Shared Examples" do
    it_behaves_like "an API response", 200, { name: "John" } do
      before { get_json(url) }
    end

    context "a successful request" do
      before do
        stub_request(:get, url)
          .to_return(status: 200, body: response_body, headers: { "Content-Type" => "application/json" })
      end

      it_behaves_like "a successful request" do
        before { get_json(url) }
      end
    end

    context "an unauthorized request" do
      before do
        stub_request(:get, url)
          .to_return(status: 401, body: "Unauthorized", headers: { "Content-Type" => "application/json" })
      end

      it_behaves_like "an unauthorized request" do
        before { get_json(url) }
      end
    end

    context "a not found response" do
      before do
        stub_request(:get, url)
          .to_return(status: 404, body: "Not Found", headers: { "Content-Type" => "application/json" })
      end

      it_behaves_like "a not found response" do
        before { get_json(url) }
      end
    end
  end

  # -------------------------------
  # 3. Testing Helpers
  # -------------------------------
  describe "Helpers" do
    it "parses JSON response using json_response helper" do
      get_json(url)
      expect(json_response).to(eq(name: "John", age: 30))
    end
  end
end
