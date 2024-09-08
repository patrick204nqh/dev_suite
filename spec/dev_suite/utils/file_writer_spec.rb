# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::FileWriter) do
  describe ".write" do
    let(:content) { "This is a test content." }

    before(:each) do
      FileUtils.mkdir_p("spec/tmp")
    end

    after(:each) do
      FileUtils.rm_rf("spec/tmp")
    end

    context "when the file is a TXT file" do
      let(:path) { "spec/tmp/test.txt" }

      it "writes the content to the TXT file" do
        described_class.write(path, content)
        expect(File.read(path)).to(eq(content))
      end
    end

    context "when the file is a JSON file" do
      let(:path) { "spec/tmp/test.json" }
      let(:json_content) { { "key" => "value" } }

      it "writes the content to the JSON file" do
        described_class.write(path, json_content)
        expect(JSON.parse(File.read(path))).to(eq(json_content))
      end
    end

    context "when the file is a YAML file" do
      let(:path) { "spec/tmp/test.yaml" }
      let(:yaml_content) { { "key" => "value" } }

      it "writes the content to the YAML file" do
        described_class.write(path, yaml_content)
        expect(YAML.load_file(path)).to(eq(yaml_content))
      end
    end
  end

  describe ".update_key" do
    let(:content) { { "key" => "value" } }

    before(:each) do
      FileUtils.mkdir_p("spec/tmp")
    end

    after(:each) do
      FileUtils.rm_rf("spec/tmp")
    end

    context "when the file is a TXT file" do
      let(:path) { "spec/tmp/test.txt" }

      it "does not update the key in the TXT file" do
        described_class.write(path, content)
        described_class.update_key(path, "key", "new_value")
        expect(File.read(path)).to(eq(content.to_s))
      end
    end

    context "when the file is a JSON file" do
      let(:path) { "spec/tmp/test.json" }

      it "updates the key in the JSON file" do
        described_class.write(path, content)
        described_class.update_key(path, "key", "new_value")
        expect(JSON.parse(File.read(path))).to(eq({ "key" => "new_value" }))
      end
    end

    context "when the file is a YAML file" do
      let(:path) { "spec/tmp/test.yaml" }

      it "updates the key in the YAML file" do
        described_class.write(path, content)
        described_class.update_key(path, "key", "new_value")
        expect(YAML.load_file(path)).to(eq({ "key" => "new_value" }))
      end
    end
  end
end
