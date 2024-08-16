# frozen_string_literal: true

module DevSuite
  module Utils
    module PathMatcher
      require_relative "pattern"
      require_relative "matcher"

      class << self
        def match?(path, includes: [], excludes: [])
          matcher = Matcher.new(includes: includes, excludes: excludes)
          matcher.match?(path)
        end
      end
    end
  end
end
