# frozen_string_literal: true

module DevSuite
  module Utils
    module PathMatcher
      class Matcher
        def initialize(includes: [], excludes: [])
          @include_patterns = includes.map { |pattern| Pattern.new(pattern) }
          @exclude_patterns = excludes.map { |pattern| Pattern.new(pattern) }
        end

        def match?(path)
          return false if excluded?(path)
          return true if included?(path)

          false
        end

        private

        def included?(path)
          @include_patterns.empty? || @include_patterns.any? { |pattern| pattern.match?(path) }
        end

        def excluded?(path)
          @exclude_patterns.any? { |pattern| pattern.match?(path) }
        end
      end
    end
  end
end
