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

          # Updates or appends structured data in the file
          def update_file_structure(file_path, key_path = nil, new_value = nil, append: false)
            with_retries do
              ensure_directory_exists(file_path)

              # Load existing data from the file
              current_data = read_or_initialize_file(file_path)

              # Modify data based on append or update operation
              updated_data = modify_structure(current_data, key_path, new_value, append)

              # Write the modified data back to the file
              atomic_write(file_path, updated_data)
            end
          end

          private

          # Reads and parses the file, or initializes a new structure if the file doesn't exist
          def read_or_initialize_file(file_path)
            if file_exists?(file_path)
              load_file_content(file_path)
            else
              initialize_new_structure
            end
          end

          # Check if the file exists
          def file_exists?(file_path)
            ::File.exist?(file_path)
          end

          # Load the file content using a file loader
          def load_file_content(file_path)
            FileLoader.load(file_path)
          end

          # Initializes a new structure (hash by default) if the file is missing
          def initialize_new_structure
            {}
          end

          # Modifies the data structure by either appending or updating
          def modify_structure(data, key_path, new_value, append)
            if append
              append_to_structure(data, new_value)
            else
              Utils::Data.set_value_by_path(data, key_path, new_value)
            end
          end

          # Appends new data to the structure (array or hash)
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

          # Perform atomic write and log success
          def perform_atomic_write(path, content)
            atomic_write(path, content)
            log_info("Successfully wrote content to #{path}")
          end

          # Performs an atomic write operation with file locking and retries
          def atomic_write(file_path, content, mode: 0o644)
            with_retries do
              ensure_directory_exists(file_path)

              # Perform atomic write with file locking
              ::File.open(file_path, "w") do |file|
                file.flock(::File::LOCK_EX) # Lock for exclusive write access
                write_to_tempfile_and_replace(file_path, content, mode)
              end
            end
          end

          # Writes to a tempfile and atomically replaces the original file
          def write_to_tempfile_and_replace(file_path, content, mode)
            ::Tempfile.create(::File.basename(file_path), ::File.dirname(file_path)) do |tempfile|
              tempfile.write(content)
              tempfile.flush
              tempfile.fsync  # Ensure data is physically written to disk
              tempfile.close  # Close tempfile before renaming

              # Atomically replace the original file with the tempfile
              ::File.rename(tempfile.path, file_path)
            end

            # Set correct file permissions
            ::File.chmod(mode, file_path)
          rescue IOError, Errno::ENOSPC => e
            log_error("Failed to write or replace the original file: #{e.message}")
            raise
          end

          # Ensures the directory for the file exists
          def ensure_directory_exists(file_path)
            directory = ::File.dirname(file_path)
            ::FileUtils.mkdir_p(directory) unless ::Dir.exist?(directory)
          end

          # Retry logic with exponential backoff for transient errors
          def with_retries
            retries = 0
            begin
              yield
            rescue IOError, Errno::ENOSPC => e
              retries += 1
              if retries <= MAX_RETRIES
                retry_with_backoff(retries, e)
              else
                log_error("Max retries reached. Error: #{e.message}")
                raise
              end
            end
          end

          # Retry operation with exponential backoff
          def retry_with_backoff(retries, error)
            delay = exponential_backoff(retries)
            log_error("Retrying due to error: #{error.message}. Retry #{retries}/#{MAX_RETRIES} in #{delay}s")
            sleep(delay)
          end

          # Exponential backoff calculation for retries
          def exponential_backoff(retries)
            RETRY_BASE_DELAY * (2**(retries - 1))
          end

          # Logs error messages
          def log_error(message)
            puts "[Error] #{message}"
          end

          # Logs successful operations
          def log_info(message)
            puts "[Info] #{message}"
          end

          # Creates a backup of the existing file before overwriting it
          def create_backup(path)
            backup_path = "#{path}.bak"
            log_info("Creating backup of #{path} at #{backup_path}")
            ::FileUtils.cp(path, backup_path)
          rescue IOError => e
            log_error("Failed to create backup for #{path}: #{e.message}")
            raise
          end

          # Create a backup if enabled
          def create_backup_if_needed(path, create_backup)
            create_backup(path) if create_backup && file_exists?(path)
          end
        end
      end
    end
  end
end
