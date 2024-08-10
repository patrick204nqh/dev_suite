require 'rspec'
require 'pathname'

RSpec.describe DevSuite::DirectoryTree do
  let(:base_path) { Pathname.new(Dir.mktmpdir) }

  before do
    #
    # Create a sample directory structure
    #
    (base_path + 'dir1').mkdir
    (base_path + 'dir1/file1.txt').write('content1')
    (base_path + 'dir2').mkdir
    (base_path + 'dir2/file2.txt').write('content2')
  end

  after do
    FileUtils.remove_entry base_path
  end

  describe '.visualize' do
    subject { described_class }

    it 'creates a new instance and calls visualize on it' do
      visualizer_instance = instance_double(DevSuite::DirectoryTree::Visualizer)
      allow(DevSuite::DirectoryTree::Visualizer).to receive(:new).and_return(visualizer_instance)
      expect(visualizer_instance).to receive(:visualize)
      subject.visualize(base_path.to_s)
    end

    it 'outputs the correct directory structure' do
      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            |   └── file1.txt
            └── dir2/
                └── file2.txt
      OUTPUT

      expect { subject.visualize(base_path.to_s) }.to output(expected_output).to_stdout
    end

    it 'handles nested directories correctly' do
      (base_path + 'dir1/subdir1').mkdir
      (base_path + 'dir1/subdir1/file3.txt').write('content3')

      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            |   ├── file1.txt
            |   └── subdir1/
            |       └── file3.txt
            └── dir2/
                └── file2.txt
      OUTPUT

      expect { subject.visualize(base_path.to_s) }.to output(expected_output).to_stdout
    end

    it 'handles empty directories correctly' do
      (base_path + 'empty_dir').mkdir

      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            |   └── file1.txt
            ├── dir2/
            |   └── file2.txt
            └── empty_dir/
      OUTPUT

      expect { subject.visualize(base_path.to_s) }.to output(expected_output).to_stdout
    end

    it 'handles directories with only files correctly' do
      (base_path + 'file_only_dir').mkdir
      (base_path + 'file_only_dir/file3.txt').write('content3')

      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            |   └── file1.txt
            ├── dir2/
            |   └── file2.txt
            └── file_only_dir/
                └── file3.txt
      OUTPUT

      expect { subject.visualize(base_path.to_s) }.to output(expected_output).to_stdout
    end

    it 'handles directories with no read permissions gracefully' do
      (base_path + 'no_read_dir').mkdir
      (base_path + 'no_read_dir').chmod(0000)

      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            |   └── file1.txt
            ├── dir2/
            |   └── file2.txt
            └── no_read_dir/
      OUTPUT

      expect { subject.visualize(base_path.to_s) }.to output(expected_output).to_stdout

      # Restore permissions for cleanup
      (base_path + 'no_read_dir').chmod(0755)
    end
  end
end
