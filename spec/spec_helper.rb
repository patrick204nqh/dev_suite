# frozen_string_literal: true

# Start SimpleCov unless in debug mode
unless ENV["DEBUG"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/spec/"           # Ignore spec directory from coverage
    track_files "lib/**/*.rb"     # Only track files in the lib directory
  end
end

require "bundler/setup"
require "rspec"
require "dev_suite"
require "pry"

# Load custom matchers and helper modules from the spec/support directory
Dir[File.join(__dir__, "support/**/*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  # Expectation configuration
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect # Use `expect` syntax exclusively
  end

  # Mock configuration
  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Shared context configuration
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Focus on examples with `:focus` metadata; useful for debugging specific tests
  config.filter_run_when_matching(:focus)

  # Persist example statuses to support `--only-failures` and `--next-failure` options
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable global monkey patching to promote cleaner syntax and reduce side effects
  config.disable_monkey_patching!

  # Randomize the order of test execution to surface order dependencies
  config.order = :random
  Kernel.srand(config.seed)

  # Uncomment the line below to enable a detailed output formatter when running a single spec file
  # config.default_formatter = "doc" if config.files_to_run.one?

  # Uncomment the line below to show Ruby warnings (e.g., global variable usage, etc.)
  # config.warnings = true

  # Uncomment the line below to profile the 10 slowest examples
  # config.profile_examples = 10
end
