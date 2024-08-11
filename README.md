# DevSuite

[![Gem Version](https://badge.fury.io/rb/dev_suite.svg)](https://badge.fury.io/rb/dev_suite)
[![Code Climate](https://codeclimate.com/github/patrick204nqh/dev_suite/badges/gpa.svg)](https://codeclimate.com/github/patrick204nqh/dev_suite)

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

## Features Overview

### Performance Analysis
<details>
  <summary>Show more</summary>
  
  **Purpose**: Quickly analyze the performance of Ruby code blocks, capturing metrics like execution time and memory usage.

  **How to Use**:
  ```ruby
  require 'dev_suite'
  
  DevSuite::Performance.analyze(description: "Example Analysis") do
    sum = 0
    1_000_000.times { |i| sum += i }
    sum
  end
  ```

  **Sample Output**:
  ```
| Metric              | Value            |
|---------------------|------------------|
| Description         | Example Analysis |
| Total Time (s)      | 0.056238         |
| User CPU Time (s)   | 0.055662         |
| System CPU Time (s) | 0.000097         |
| Memory Before (MB)  | 25.39            |
| Memory After (MB)   | 25.42            |
| Memory Used (MB)    | 0.03             |
  ```
</details>

### Directory Tree Visualization
<details>
  <summary>Show more</summary>
  
  **Purpose**: Visualize the file structure of directories and subdirectories to better understand project organization.

  **How to Use**:
  ```ruby
  require 'dev_suite'

  # Define the directory path
  base_path = "/path/to/your/directory"

  # Execute the visualization
  DevSuite::DirectoryTree.visualize(base_path)
  ```

  **Configuration Guide**:
  Customize the visualization by setting configuration options:
  ```ruby
  DevSuite::DirectoryTree::Config.configure do |config|
    config.settings.set(:skip_hidden, true)
    # ...
  end
  ```

  **Configuration Options**:
| Setting        | Description                                       | Example Values           |
|----------------|---------------------------------------------------|--------------------------|
| `:skip_hidden` | Skips hidden files and directories.               | `true`, `false`          |
| `:max_depth`   | Limits the depth of the directory tree displayed. | `1`, `2`, `3`, ...       |
| `:skip_types`  | Excludes files of specific types.                 | `['.log', '.tmp']`, `[]` |

  **Sample Output**:
  ```
  /path/to/your/directory/
  ├── project/
  │   ├── src/
  │   │   ├── main.rb
  │   │   └── helper.rb
  │   └── spec/
  │       └── main_spec.rb
  ├── doc/
  │   └── README.md
  └── test/
      └── test_helper.rb
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
