# frozen_string_literal: true

module DevSuite
  module Utils
    module PathMatcher
      class Pattern
        def initialize(pattern)
          @regex = convert_to_regex(pattern)
        end

        def match?(path)
          !!(@regex =~ path)
        end

        private

        def convert_to_regex(pattern)
          # Escape all regex special characters except '*'
          pattern = Regexp.escape(pattern).gsub('\*', "*")

          # Convert glob patterns to regex:
          # - '**/' matches any directory level
          # - '*.txt' matches any .txt file in any directory
          pattern = pattern.gsub("**", ".*") # ** -> .*
          pattern = pattern.gsub("*", "[^/]*") # * -> [^/]*

          # Allow '*.txt' to match any .txt file in any directory by prefixing with '.*'
          pattern = ".*#{pattern}" unless pattern.start_with?(".*")

          Regexp.new("^#{pattern}$")
        end
      end
    end
  end
end
