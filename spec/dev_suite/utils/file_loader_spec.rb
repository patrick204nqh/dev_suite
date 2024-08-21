# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::FileLoader) do
  describe ".load" do
    context "when the file is a TXT file" do
      let(:path) { "spec/fixtures/files/test.txt" }

      it "loads the file" do
        expect(described_class.load(path)).to(eq("This is a test text file."))
      end
    end

    context "when the file is a JSON file" do
      let(:path) { "spec/fixtures/files/test.json" }

      it "loads the file" do
        expect(described_class.load(path)).to(eq({ "key" => "value" }))
      end
    end

    context "when the file is a YAML file" do
      let(:path) { "spec/fixtures/files/test.yaml" }

      it "loads the file" do
        expect(described_class.load(path)).to(eq({ "key" => "value" }))
      end
    end
  end
end
