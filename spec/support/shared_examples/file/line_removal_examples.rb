# frozen_string_literal: true

module FileExamples
  module LineRemovalExamples
    RSpec.shared_examples("a file with specific lines removed") do |content|
      let(:path) { File.join(TMP_DIR, "test.txt") }

      it "deletes lines in the file" do
        described_class.write(path, content)
        described_class.delete_lines(path, 1, 2) # Deletes lines 1 to 2

        read_content = File.read(path)
        expected_content = "Line 3\nLine 4\nLine 5"
        expect(read_content).to(eq(expected_content))
      end
    end
  end
end

RSpec.configure do |config|
  config.include(FileExamples::LineRemovalExamples)
end
