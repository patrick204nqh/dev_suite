# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Yaml < Base
          # Write a hash or array of hashes as YAML content to a file
          def write(path, content, normalize: false, create_backup: false, yaml_options: {})
            validate_content(content)
            create_backup_if_needed(path, create_backup)
            yaml_content = prepare_yaml_content(content, normalize, yaml_options)
            perform_atomic_write(path, yaml_content)
          rescue IOError => e
            handle_write_error("YAML", path, e, specific_error: "I/O error")
          rescue ::YAML::SyntaxError => e
            handle_write_error("YAML", path, e, specific_error: "YAML syntax error")
          end

          private

          # Prepare YAML content by normalizing and applying options
          def prepare_yaml_content(content, normalize, yaml_options)
            normalized_content = normalize ? normalize_yaml(content) : content
            ::YAML.dump(normalized_content, yaml_options)
          end

          # Log and raise errors during the write process
          def handle_write_error(format, path, error, specific_error: nil)
            message = specific_error || "Error writing #{format} to #{path}: #{error.message}"
            log_error(message)
            raise
          end

          # Validates that content is a Hash or an Array of Hashes
          def validate_content(content)
            unless valid_content?(content)
              raise ArgumentError, "Content must be a Hash or an Array of Hashes"
            end
          end

          # Check if content is a valid Hash or an Array of Hashes
          def valid_content?(content)
            content.is_a?(Hash) || (content.is_a?(Array) && content.all? { |item| item.is_a?(Hash) })
          end

          # Normalize the YAML content (e.g., sort keys)
          def normalize_yaml(content)
            content.is_a?(Hash) ? content.sort.to_h : content
          end
        end
      end
    end
  end
end
