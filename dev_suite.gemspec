# frozen_string_literal: true

require_relative "lib/dev_suite/version"

Gem::Specification.new do |spec|
  spec.name          = "dev_suite"
  spec.version       = DevSuite::VERSION
  spec.authors       = ["Huy Nguyen"]
  spec.email         = ["patrick204nqh@gmail.com"]

  spec.summary       = "A suite of development tools."
  spec.description   = "This gem provides a suite of utilities for developers to enhance their productivity."
  spec.homepage      = "https://patrick204nqh.github.io"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/patrick204nqh/dev_suite"
  spec.metadata["changelog_uri"] = "https://github.com/patrick204nqh/dev_suite/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("benchmark", "~> 0.1")
  spec.add_dependency("get_process_mem", "~> 0.2")
end
