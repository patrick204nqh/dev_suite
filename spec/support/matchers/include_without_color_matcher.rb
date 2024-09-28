# frozen_string_literal: true

module IncludeWithoutColorMatcher
  # Helper method to remove ANSI color codes from a string
  def strip_ansi_codes(text)
    text.gsub(/\e\[(\d+)(;\d+)*m/, "")
  end

  # Custom RSpec matcher to check for text ignoring ANSI color codes
  RSpec::Matchers.define(:include_without_color) do |expected|
    match do |actual|
      strip_ansi_codes(actual).include?(expected)
    end

    failure_message do |actual|
      "expected '#{strip_ansi_codes(actual)}' to include '#{expected}'"
    end

    description do
      "include '#{expected}' without considering ANSI color codes"
    end
  end
end

RSpec.configure do |config|
  config.include(IncludeWithoutColorMatcher)
end
