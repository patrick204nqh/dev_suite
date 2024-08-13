require 'simplecov'
SimpleCov.start do
  # Ignore spec directory
  add_filter '/spec/'
  
  # Only track files in the lib directory
  track_files 'lib/**/*.rb'
end

require "bundler/setup"
require "dev_suite"

RSpec.configure do |config|
  # Use the expect syntax for cleaner and more modern syntax
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  # Configure RSpec to only allow expect syntax to avoid confusion and ensure consistency
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Apply shared context metadata globally to all groups and examples
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Allow focusing on a specific test or group by setting `:focus` metadata
  config.filter_run_when_matching :focus

  # Persist the state of specs between runs (useful for --only-failures option)
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec's monkey patching of the top-level DSL globally
  config.disable_monkey_patching!

  # Optionally enable a different formatter when running a single file
  # Uncomment to enable a documentation formatter when running individual specs
  # config.default_formatter = "doc" if config.files_to_run.one?
  
  # Randomize the order tests are executed
  config.order = :random
  Kernel.srand config.seed

  # Output all global variables and method definitions from examples (can be noisy)
  # config.warnings = true

  # Print the 10 slowest examples and example groups at the end of the spec run
  # config.profile_examples = 10
end