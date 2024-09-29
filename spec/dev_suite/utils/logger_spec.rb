# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Logger) do
  let(:output) { StringIO.new }
  let(:logger_instance) { described_class.logger }

  before do
    allow(logger_instance).to(receive(:output_log) { |message| output.puts(message) })
  end

  describe ".log" do
    it "logs a message using the default global logger" do
      described_class.log("Test message", level: :info, emoji: :start)
      expect(output.string).to(include("Test message"))
    end

    it "logs a message with the specified log level, emoji, and prefix" do
      described_class.log("Error occurred", level: :error, emoji: :start, prefix: "[CUSTOM]")
      expect(output.string).to(include("[CUSTOM] 🚀 Error occurred"))
    end

    it "raises an error for invalid log levels" do
      expect do
        described_class.log("Invalid level test", level: :invalid)
      end.to(raise_error(DevSuite::Utils::Logger::InvalidLogLevelError))
    end
  end
end
