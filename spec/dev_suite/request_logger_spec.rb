# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::RequestLogger) do
  let(:url) { "https://jsonplaceholder.typicode.com/todos/1" }
  let(:uri) { URI.parse(url) }

  describe ".with_logging" do
    context "when adapter :net_http is enabled" do
      before do
        DevSuite::RequestLogger::Config.configure do |config|
          config.adapters = [:net_http]
        end
      end

      it "logs the request" do
        expect do
          DevSuite::RequestLogger.with_logging do
            Net::HTTP.get(uri)
          end
        end.to(output.to_stdout)
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

    context "when adapter :faraday" do
      context "is enabled" do
        let(:connection) do
          Faraday.new(url: url) do |faraday|
            faraday.adapter(Faraday.default_adapter)
          end
        end

        before do
          require "faraday"
          DevSuite::RequestLogger::Config.configure do |config|
            config.adapters = [:faraday]
          end
        end

        it "logs the request" do
          expect do
            DevSuite::RequestLogger.with_logging do
              connection.get("/")
            end
          end.to(output.to_stdout)
        end

        it "calls enable and disable on the adapter" do
          adapter = DevSuite::RequestLogger::Config.configuration.adapters.first

          expect(adapter).to(receive(:enable).ordered.and_call_original)
          expect(adapter).to(receive(:disable).ordered.and_call_original)

          DevSuite::RequestLogger.with_logging do
            connection.get("/")
          end
        end
      end

      # This context is a bit tricky.
      # It simulates the absence of the Faraday constant by removing it from the Object namespace.
      # This is done to test the behavior of the RequestLogger when the Faraday constant is not available.
      xcontext "fails to load" do
        before do
          # Store the original top-level Faraday constant if it's defined
          @original_faraday = Faraday if defined?(Faraday)

          # Remove the top-level Faraday constant to simulate its absence
          Object.send(:remove_const, :Faraday) if defined?(Faraday)

          DevSuite::RequestLogger::Config.configure do |config|
            config.adapters = [:faraday]
          end
        end

        after do
          # Restore the top-level Faraday constant after the test
          Object.const_set(:Faraday, @original_faraday) if @original_faraday
        end

        it "handles the failure and removes the faraday adapter" do
          expect do
            DevSuite::RequestLogger.with_logging do
              Net::HTTP.get(uri)
            end
          end.not_to(raise_error)

          expect(DevSuite::RequestLogger::Config.configuration.adapters).not_to(include(:faraday))
          expect(DevSuite::RequestLogger::Config.configuration.missing_dependencies).to(include("faraday"))
        end
      end
    end
  end
end
