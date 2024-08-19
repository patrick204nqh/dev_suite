require 'spec_helper'
require 'tmpdir'

RSpec.describe DevSuite::DirectoryTree do
  let(:base_path) { Pathname.new(Dir.mktmpdir) }

  before do
    FileUtils.mkdir_p(base_path + 'dir1')
    FileUtils.mkdir_p(base_path + 'dir1/subdir1')
    File.write(base_path + 'dir1/file1.txt', 'content1')
    File.write(base_path + 'dir1/subdir1/hidden_file.txt', 'hidden content', mode: 'w')

    FileUtils.mkdir_p(base_path + 'dir2')
    File.write(base_path + 'dir2/file2.txt', 'content2')

    FileUtils.mkdir_p(base_path + '.hidden_dir')
    File.write(base_path + '.hidden_dir/hidden_file2.txt', 'hidden content 2')
  end

  after do
    FileUtils.remove_entry_secure(base_path)
  end

  describe '.visualize' do
    after { DevSuite::DirectoryTree::Config.reset! }

    it 'outputs the correct directory structure' do
      expected_output = <<~OUTPUT
        #{base_path.basename}/
            ├── dir1/
            │   ├── file1.txt
            │   └── subdir1/
            │       └── hidden_file.txt
            ├── dir2/
            │   └── file2.txt
            └── .hidden_dir/
                └── hidden_file2.txt
      OUTPUT

      expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
    end

    context 'when skipping hidden files and directories' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:skip_hidden, true)
        end
      end

      it 'does not include hidden files and directories' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              │   ├── file1.txt
              │   └── subdir1/
              │       └── hidden_file.txt
              └── dir2/
                  └── file2.txt
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'when setting a max depth' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:max_depth, 1)
        end
      end

      it 'limits the output to the specified depth' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              ├── dir2/
              └── .hidden_dir/
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'when excluding specific file types' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:skip_types, ['.txt'])
        end
      end

      it 'does not include specified file types' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              │   └── subdir1/
              ├── dir2/
              └── .hidden_dir/
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'when setting a max size' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:max_size, 1) # 1 byte
        end
      end

      it 'raises an error if the directory size exceeds the max size' do
        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to raise_error(ArgumentError, "Directory too large to render")
      end
    end

    context 'when including specific files and directories' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:includes, ['dir1/*'])
        end
      end

      it 'only includes the specified files and directories' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              └── dir1/
                  ├── file1.txt
                  └── subdir1/
                      └── hidden_file.txt
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'when excluding specific files and directories' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:exclude, ['dir1/subdir1', '.hidden_dir'])
        end
      end

      it 'excludes the specified files and directories' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              │   └── file1.txt
              └── dir2/
                  └── file2.txt
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'when using both include and exclude settings' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:include, ['*.txt', '**/dir1/**/*'])
          config.settings.set(:exclude, ['**/dir1/subdir1'])
        end
      end

      it 'applies both include and exclude settings correctly' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              │   └── file1.txt
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end

    context 'complex settings' do
      before do
        DevSuite::DirectoryTree::Config.configure do |config|
          config.settings.set(:skip_hidden, true)
          config.settings.set(:skip_types, ['.txt'])
          config.settings.set(:max_depth, 1)
        end
      end

      it 'applies multiple settings correctly' do
        expected_output = <<~OUTPUT
          #{base_path.basename}/
              ├── dir1/
              └── dir2/
        OUTPUT

        expect { DevSuite::DirectoryTree.visualize(base_path.to_s) }.to output(expected_output).to_stdout
      end
    end
  end
end