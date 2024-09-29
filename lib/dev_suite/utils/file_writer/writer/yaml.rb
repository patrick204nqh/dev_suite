# frozen_string_literal: true

module DevSuite
  module Utils
    module FileWriter
      module Writer
        class Yaml < Base
          def write(content, normalize: false, backup: false, yaml_options: {})
            validate_content(content)
            create_backup(path) if backup

            yaml_content = prepare_yaml_content(content, normalize, yaml_options)
            AtomicWriter.new(path, yaml_content).write
          end

          def append(content)
            current_content = read
            updated_content = current_content.merge(content)
            write(updated_content)
          end

          private

          # Prepare YAML content by normalizing and applying options
          def prepare_yaml_content(content, normalize, yaml_options)
            normalized_content = normalize ? normalize_yaml(content) : content
            ::YAML.dump(normalized_content, yaml_options)
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
