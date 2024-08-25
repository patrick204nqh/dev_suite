# frozen_string_literal: true

source "https://rubygems.org"

# Use the gemspec method to include dependencies specified in the gemspec file
gemspec

# Additional runtime dependencies
gem "faraday", "~> 1.4"

# Additional development tools not required as part of the gem's runtime
group :development, :test do
  gem "rspec", "~> 3.9"
  gem "rspec-core", "~> 3.9"
  gem "rspec-support", "~> 3.9"
  gem "simplecov", "~> 0.21"
  gem "rake", "~> 13.0"
end

group :development do
  gem "pry", "~> 0.14"
  gem "rubocop", "~> 1.65", require: false
  gem "rubocop-shopify", "~> 2.15", require: false
end
