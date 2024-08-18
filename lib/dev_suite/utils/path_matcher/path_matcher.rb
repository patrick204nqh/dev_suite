# frozen_string_literal: true

module DevSuite
  module Utils
    module PathMatcher
      require_relative "pattern"
      require_relative "matcher"

      class << self
        def match?(path, includes: [], excludes: [])
          raise ArgumentError, "Path must be a Pathname" unless path.is_a?(Pathname)

          # Convert path to string for easier manipulation
          path_str = path.cleanpath.to_s

          # If both includes and excludes are empty, nothing is matched
          return false if includes.empty? && excludes.empty?

          # Normalize patterns to ensure consistent matching
          normalized_includes = normalize_patterns(includes)
          normalized_excludes = normalize_patterns(excludes)

          # Match against exclude patterns first (higher precedence)
          excluded = normalized_excludes.any? { |pattern| custom_fnmatch(pattern, path_str) }
          return false if excluded

          # Match against include patterns
          included = normalized_includes.empty? || normalized_includes.any? { |pattern| custom_fnmatch(pattern, path_str) }

          included
        end

        def custom_fnmatch(pattern, path)
          # Custom fnmatch to handle "*.txt" for matching files in any directory
          if pattern.start_with?('**/')
            pattern = pattern.sub('**/', '**/')
          elsif pattern == '*.txt'
            # Convert `*.txt` to match `.txt` files in any directory
            pattern = '**/*.txt'
          end

          File.fnmatch(pattern, path, File::FNM_PATHNAME | File::FNM_DOTMATCH)
        end

        def normalize_patterns(patterns)
          patterns.map { |pattern| pattern.start_with?('/') ? pattern : "**/#{pattern}" }
        end
      end
    end
  end
end
