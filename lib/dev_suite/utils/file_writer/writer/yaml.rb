# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Yaml < Base
          # Write a hash or array of hashes as YAML content to a file
          def write(path, content, normalize: false, create_backup: false, yaml_options: {})
            # Validate content before writing
            validate_content(content)

            # Step 1: Normalize the content (sort keys) if required
            yaml_content = normalize ? normalize_yaml(content) : content

            # Step 2: Create a backup of the file if it exists and backup option is enabled
            create_backup(path) if create_backup && file_exists?(path)

            # Step 3: Convert to YAML and perform atomic write with options
            atomic_write(path, ::YAML.dump(yaml_content, yaml_options))
          rescue IOError => e
            log_error("I/O error while writing YAML to #{path}: #{e.message}")
            raise
          rescue ::YAML::SyntaxError => e
            log_error("YAML syntax error in content: #{e.message}")
            raise
          else
            log_info("Successfully wrote YAML content to #{path}")
          end

          private

          # Validates that content is a Hash or an Array of Hashes
          def validate_content(content)
            if !content.is_a?(Hash) && !(content.is_a?(Array) && content.all? { |item| item.is_a?(Hash) })
              raise ArgumentError, "Content must be a Hash or an Array of Hashes"
            end
          end

          # Normalize the YAML content (e.g., sort keys)
          def normalize_yaml(content)
            content.is_a?(Hash) ? content.sort.to_h : content
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

          # Logs successful operations
          def log_info(message)
            puts "[Info] #{message}"
          end
        end
      end
    end
  end
end
