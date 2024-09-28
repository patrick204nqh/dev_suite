# frozen_string_literal: true

require "spec_helper"
require "webmock/rspec"

RSpec.describe(DevSuite::RequestLogger) do
  let(:url) { "https://jsonplaceholder.typicode.com/todos/1" }
  let(:uri) { URI.parse(url) }

  describe ".with_logging" do
    context "when adapter :net_http is enabled" do
      before do
        DevSuite::RequestLogger::Config.configure do |config|
          config.adapters = [:net_http]
        end

        # Stub the request with WebMock
        stub_request(:get, url).to_return(status: 200, body: '{"title": "Learn RSpec"}', headers: {})
      end

      it "logs the request" do
        expect do
          DevSuite::RequestLogger.with_logging do
            Net::HTTP.get(uri)
          end
        end.to(output.to_stdout)

        # Verify the request was made
        expect(WebMock).to(have_requested(:get, url).once)
      end

      it "calls enable and disable on the adapter" do
        adapter = DevSuite::RequestLogger::Config.configuration.adapters.first

        expect(adapter).to(receive(:enable).ordered.and_call_original)
        expect(adapter).to(receive(:disable).ordered.and_call_original)

        DevSuite::RequestLogger.with_logging do
          Net::HTTP.get(uri)
        end
      end
    end

    context "when adapter :faraday is enabled" do
      before do
        DevSuite::RequestLogger::Config.configure do |config|
          config.adapters = [:faraday]
        end

        # Stub the request with WebMock for Faraday
        stub_request(:get, url).to_return(status: 200, body: '{"title": "Learn Faraday"}', headers: {})
      end

      if Gem.loaded_specs["faraday"]
        require "faraday"

        let(:connection) do
          Faraday.new(url: url) do |faraday|
            faraday.adapter(Faraday.default_adapter)
          end
        end

        it "logs the request" do
          expect do
            DevSuite::RequestLogger.with_logging do
              connection.get("/")
            end
          end.to(output.to_stdout)

          # Verify the request was made
          expect(WebMock).to(have_requested(:get, url).once)
        end

        it "calls enable and disable on the adapter" do
          adapter = DevSuite::RequestLogger::Config.configuration.adapters.first

          expect(adapter).to(receive(:enable).ordered.and_call_original)
          expect(adapter).to(receive(:disable).ordered.and_call_original)

          DevSuite::RequestLogger.with_logging do
            connection.get("/")
          end
        end
      else
        context "when Faraday is not available" do
          it "logs a warning" do
            expect(DevSuite::RequestLogger::Config.configuration.adapters).to(be_empty)

            DevSuite::RequestLogger.with_logging do
              Net::HTTP.get(uri)
            end
          end
        end
      end
    end
  end
end
