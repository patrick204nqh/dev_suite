# frozen_string_literal: true

require "spec_helper"
require "faraday"

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
      let(:connection) do
        Faraday.new(url: url) do |faraday|
          faraday.adapter(Faraday.default_adapter)
        end
      end

      context "is enabled" do
        before do
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

      context "fails to load" do
        before do
          DevSuite::RequestLogger::Config.configure do |config|
            config.adapters = [:faraday]
          end

          # Simulate Faraday failing to load
          allow(DevSuite::Utils::DependencyLoader).to(receive(:safe_load_dependencies).and_yield)
          allow(Kernel).to(receive(:require).with("faraday").and_raise(LoadError))
        end

        it "handles the failure and removes the faraday adapter" do
          expect do
            DevSuite::RequestLogger.with_logging do
              connection.get("/")
            end
          end.not_to(raise_error)

          expect(DevSuite::RequestLogger::Config.configuration.adapters).not_to(include(:faraday))
          expect(DevSuite::RequestLogger::Config.configuration.missing_dependencies).to(include("faraday"))
        end
      end
    end
  end
end
