# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      class AtomicWriter
        def initialize(path, content, mode: 0o644)
          @path = path
          @content = content
          @mode = mode
        end

        def write
          ensure_directory_exists

          ::File.open(@path, "w") do |file|
            file.flock(::File::LOCK_EX) # Lock for exclusive write access
            write_to_tempfile_and_replace
          end
        end

        private

        def write_to_tempfile_and_replace
          temp_path = "#{@path}.tmp"
          begin
            ::File.open(temp_path, "w") do |tempfile|
              tempfile.write(@content)
              tempfile.flush
              tempfile.fsync # Ensure data is physically written to disk
            end

            # Atomically replace the original file with the temporary file
            ::File.rename(temp_path, @path)

            # Set correct file permissions
            ::File.chmod(@mode, @path)
          rescue IOError, Errno::ENOSPC => e
            raise "Failed to write or replace the original file: #{e.message}"
          ensure
            # Clean up the temporary file if it still exists
            ::File.delete(temp_path) if ::File.exist?(temp_path)
          end
        end

        def ensure_directory_exists
          directory = ::File.dirname(@path)
          ::FileUtils.mkdir_p(directory) unless ::Dir.exist?(directory)
        end
      end
    end
  end
end
