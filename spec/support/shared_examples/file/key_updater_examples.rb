# frozen_string_literal: true

module FileExamples
  module KeyUpdaterExamples
    RSpec.shared_examples("a file with an updated key-value pair") do |file_type, content|
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
  end
end

RSpec.configure do |config|
  config.include(FileExamples::KeyUpdaterExamples)
end
