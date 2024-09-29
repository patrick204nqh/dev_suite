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

  # -------------------------------
  # Shared Examples for Writing, Appending, and Updating Keys
  # -------------------------------

  shared_examples "a file writer" do |file_type, content|
    let(:path) { File.join(TMP_DIR, "test.#{file_type}") }

    it "writes content to the #{file_type} file" do
      described_class.write(path, content)
      expect(File.exist?(path)).to(be(true))

      read_content = read_file_content(path, file_type)
      expect(read_content).to(eq(content))
    end

    it "appends content to the #{file_type} file" do
      described_class.write(path, content)
      append_content = file_type == :txt ? "Appended line." : { "new_key" => "new_value" }
      described_class.append(path, append_content)

      read_content = read_file_content(path, file_type)
      expected_content = append_expected_content(content, append_content, file_type)

      expect(read_content).to(eq(expected_content))
    end
  end

  shared_examples "a key updater" do |file_type, content|
    let(:path) { File.join(TMP_DIR, "test.#{file_type}") }

    it "updates the key in the #{file_type} file" do
      next if file_type == :txt # Skip updating keys for plain text files

      described_class.write(path, content)
      described_class.update_key(path, "key", "new_value")

      read_content = read_file_content(path, file_type)
      expected_content = { "key" => "new_value" }
      expect(read_content).to(eq(expected_content))
    end

    it "deletes the key in the #{file_type} file" do
      next if file_type == :txt # Skip deleting keys for plain text files

      described_class.write(path, content)
      described_class.delete_key(path, "key")

      read_content = read_file_content(path, file_type)
      expected_content = {}
      expect(read_content).to(eq(expected_content))
    end
  end

  shared_examples "a line deleter" do |content|
    let(:path) { File.join(TMP_DIR, "test.txt") }

    it "deletes lines in the file" do
      described_class.write(path, content)
      described_class.delete_lines(path, 1, 2) # Deletes lines 1 to 2

      read_content = File.read(path)
      expected_content = "Line 3\nLine 4\nLine 5"
      expect(read_content).to(eq(expected_content))
    end
  end

  # -------------------------------
  # Tests for TXT Files
  # -------------------------------

  context "when working with a TXT file" do
    include_examples "a file writer", :txt, "This is a test content."
    include_examples "a line deleter", "Line 1\nLine 2\nLine 3\nLine 4\nLine 5"
  end

  # -------------------------------
  # Tests for JSON Files
  # -------------------------------

  context "when working with a JSON file" do
    include_examples "a file writer", :json, { "key" => "value" }
    include_examples "a key updater", :json, { "key" => "value" }
  end

  # -------------------------------
  # Tests for YAML Files
  # -------------------------------

  context "when working with a YAML file" do
    include_examples "a file writer", :yaml, { "key" => "value" }
    include_examples "a key updater", :yaml, { "key" => "value" }
  end

  # -------------------------------
  # Helper Methods
  # -------------------------------

  def read_file_content(path, file_type)
    case file_type
    when :txt
      File.read(path).strip
    when :json
      JSON.parse(File.read(path))
    when :yaml
      YAML.load_file(path)
    end
  end

  def append_expected_content(original_content, append_content, file_type)
    case file_type
    when :txt
      "#{original_content.strip}\n#{append_content.strip}"
    when :json, :yaml
      original_content.merge(append_content)
    end
  end
end
