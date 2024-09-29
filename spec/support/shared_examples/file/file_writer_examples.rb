# frozen_string_literal: true

module FileExamples
  module FileWriterExamples
    RSpec.shared_examples("a file that supports writing and appending content") do |file_type, content|
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
  end
end

RSpec.configure do |config|
  config.include(FileExamples::FileWriterExamples)
end
