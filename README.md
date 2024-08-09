# DevSuite

Welcome to DevSuite! This gem provides a suite of utilities for developers to enhance their productivity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dev_suite'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install dev_suite
```

## Usage

To use DevSuite, require it in your Ruby code:

```ruby
require 'dev_suite'
```

### Example Usage

```ruby
# Example of using a utility from DevSuite
DevSuite::SomeUtility.do_something
```

## Features

<details>
  <summary><strong>Performance Analysis</strong></summary>
  
  Analyze the performance of your code blocks with detailed benchmark and memory usage reports.
  
  **Usage:**
  ```ruby
  require 'dev_suite'

  DevSuite::Performance::Analyzer.analyze(description: "My Code Block") do
    # Your code here
  end
  ```
</details>


## Development

After checking out the repo, run `bin/setup`for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:

```sh
$ bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run:

```sh
$ bundle exec rake release
```

This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patrick204nqh/dev_suite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/patrick204nqh/dev_suite/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DevSuite project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/patrick204nqh/dev_suite/blob/master/CODE_OF_CONDUCT.md).
