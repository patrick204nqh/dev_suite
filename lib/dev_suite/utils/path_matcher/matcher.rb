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
          return true if included?(path) || any_child_included?(path)

          false
        end

        private

        def included?(path)
          @include_patterns.empty? || @include_patterns.any? { |pattern| pattern.match?(path) }
        end

        def excluded?(path)
          @exclude_patterns.any? { |pattern| pattern.match?(path) }
        end

        def any_child_included?(path)
          return false unless path.directory?

          path.children.any? { |child| included?(child) || any_child_included?(child) }
        end
      end
    end
  end
end
