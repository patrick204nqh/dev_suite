# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        class Yaml < Base
          class << self
            def extensions
              ["yml", "yaml"]
            end
          end

          def load(path, safe: true)
            validate_file_existence!(path)
            parse_yaml_file(path, safe)
          rescue ::Psych::SyntaxError => e
            handle_yaml_parsing_error(path, e)
          end

          private

          def validate_file_existence!(path)
            raise "File not found: #{path}" unless ::File.exist?(path)
          end

          def parse_yaml_file(path, safe)
            safe ? ::YAML.safe_load_file(path) : ::YAML.load_file(path)
          end

          def handle_yaml_parsing_error(path, error)
            raise "YAML parsing error in file #{path}: #{error.message}"
          end
        end
      end
    end
  end
end
