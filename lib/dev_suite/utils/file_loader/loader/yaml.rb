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
            raise "File not found: #{path}" unless ::File.exist?(path)

            safe ? ::YAML.safe_load_file(path) : ::YAML.load_file(path)
          rescue ::Psych::SyntaxError => e
            raise "YAML parsing error in file #{path}: #{e.message}"
          end
        end
      end
    end
  end
end
