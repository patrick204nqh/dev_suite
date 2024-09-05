# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          MAX_RETRIES = 5           # Max retry attempts for transient errors
          RETRY_BASE_DELAY = 0.2    # Base delay between retries (will use backoff)

          def write(_path, _content)
            raise NotImplementedError, "Subclasses must implement the `write` method"
          end

          private

          # Ensures the directory for the file exists
          def create_directory_if_missing(path)
            directory = ::File.dirname(path)
            ::FileUtils.mkdir_p(directory) unless ::Dir.exist?(directory)
          end

          # Perform atomic write with locking and retries
          def perform_atomic_write(path, content, mode: 0o644)
            retries = 0
            begin
              create_directory_if_missing(path)

              # Acquire a file lock to prevent race conditions
              ::File.open(path, "w") do |file|
                file.flock(::File::LOCK_EX) # Lock for exclusive write access

                # Atomic write to tempfile and replace the original file
                write_to_tempfile_and_replace(path, content, mode)
              end
            rescue IOError, Errno::ENOSPC => e
              retries += 1
              if retries <= MAX_RETRIES
                delay = exponential_backoff_delay(retries)
                log_error_and_retry("I/O error or space issue: #{e.message}. Retrying in #{delay}s...", retries)
                sleep(delay)
                retry
              else
                log_error("I/O error after #{MAX_RETRIES} retries: #{e.message}")
                raise
              end
            rescue StandardError => e
              log_error("Unhandled error while writing to file: #{e.message}")
              raise
            end
          end

          # Handles the actual writing to a tempfile and renaming it for atomic write
          def write_to_tempfile_and_replace(path, content, mode)
            # Use Tempfile in the same directory to ensure atomicity
            ::Tempfile.create(::File.basename(path), ::File.dirname(path)) do |tempfile|
              tempfile.write(content)
              tempfile.flush
              tempfile.fsync  # Ensure data is physically written to disk
              tempfile.close  # Close tempfile before renaming

              # Lock the target file during the rename to avoid race conditions
              begin
                ::File.rename(tempfile.path, path)
              rescue StandardError => e
                raise IOError, "Failed to rename tempfile to target: #{e.message}"
              end
            end

            # Set the correct permissions for the final file
            ::File.chmod(mode, path)
          rescue IOError => e
            log_error("I/O error during tempfile creation or replacement: #{e.message}")
            raise
          rescue Errno::ENOSPC => e
            log_error("No space left during tempfile creation: #{e.message}")
            raise
          rescue StandardError => e
            log_error("Unexpected error during atomic write: #{e.message}")
            raise
          end

          # Exponential backoff delay for retries
          def exponential_backoff_delay(retries)
            RETRY_BASE_DELAY * (2**(retries - 1))
          end

          # Log errors and retry attempts
          def log_error_and_retry(message, retry_count)
            puts "[Retry #{retry_count}] #{message}"
          end

          # Log any error messages with context
          def log_error(message)
            puts "[Error] #{message}"
          end
        end
      end
    end
  end
end
