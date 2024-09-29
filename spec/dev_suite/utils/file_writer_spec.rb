# frozen_string_literal: true

require "spec_helper"

TMP_DIR = "spec/tmp"

RSpec.describe(DevSuite::Utils::FileWriter) do
  before(:each) do
    FileUtils.mkdir_p(TMP_DIR)
  end

  after(:each) do
    FileUtils.rm_rf(TMP_DIR)
  end

  context "when working with a TXT file" do
    include_examples "a file that supports writing and appending content", :txt, "This is a test content."
    include_examples "a file with specific lines removed", "Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
  end

  context "when working with a JSON file" do
    include_examples "a file that supports writing and appending content", :json, { "key" => "value" }
    include_examples "a file with an updated key-value pair", :json, { "key" => "value" }
  end

  context "when working with a YAML file" do
    include_examples "a file that supports writing and appending content", :yaml, { "key" => "value" }
    include_examples "a file with an updated key-value pair", :yaml, { "key" => "value" }
  end
end
