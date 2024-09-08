# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Base < Utils::Construct::Component::Base
          MAX_RETRIES = 5           # Max retry attempts for transient errors
          RETRY_BASE_DELAY = 0.2    # Base delay between retries (will use backoff)

          # Abstract method that subclasses must implement for custom file write operations
          def write(_path, _content)
            raise NotImplementedError, "Subclasses must implement the `write` method"
          end

          # Update a particular part of the structured data (e.g., JSON) in the file
          # Supports appending new data if 'append' is true
          def update_data_structure(path, key_path = nil, new_value = nil, append: false)
            retries = 0
            begin
              create_directory_if_missing(path)

              # Load existing data
              current_data = read_file(path, append: append)

              # If append is true, append the new data; otherwise, update the specific key path
              updated_data =
                if append
                  append_to_structure(current_data, new_value)
                else
                  Utils::Data.set_value_by_path(current_data, key_path, new_value)
                end

              # Write the modified data back to the file
              perform_atomic_write(path, updated_data.to_json)
            rescue IOError, Errno::ENOSPC => e
              retries += 1
              retry_on_failure(e, retries)
            rescue StandardError => e
              log_error("Unhandled error while writing to file: #{e.message}")
              raise
            end
          end

          private

          # Read and parse the file content as JSON, or initialize a new structure if the file doesn't exist
          def read_file(path, append: false)
            if ::File.exist?(path)
              FileLoader.load(path)
            else
              log_error("File does not exist, initializing new structure.") unless append
              {} # Initialize a new data structure if the file does not exist
            end
          rescue JSON::ParserError => e
            log_error("Failed to parse JSON: #{e.message}")
            raise
          end

          # Append new data to the structure (only appends if the structure is an array or hash)
          def append_to_structure(data, new_value)
            case data
            when Array
              data << new_value
            when Hash
              data.merge!(new_value)
            else
              raise TypeError, "Unsupported data structure for append operation"
            end
            data
          end

          # Perform atomic write with locking and retries
          def perform_atomic_write(path, content, mode: 0o644)
            retries = 0
            begin
              create_directory_if_missing(path)

              # Acquire a file lock to prevent race conditions
              ::File.open(path, "w") do |file|
                file.flock(::File::LOCK_EX) # Lock for exclusive write access
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

              # Replace the original file with the tempfile atomically
              ::File.rename(tempfile.path, path)
            end

            # Set the correct permissions for the final file
            ::File.chmod(mode, path)
          rescue IOError, Errno::ENOSPC => e
            log_error("I/O error during tempfile creation or replacement: #{e.message}")
            raise
          end

          # Create the directory if it doesn't exist
          def create_directory_if_missing(path)
            directory = ::File.dirname(path)
            ::FileUtils.mkdir_p(directory) unless ::Dir.exist?(directory)
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
