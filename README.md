# DevSuite

[![Gem Version](https://img.shields.io/gem/v/dev_suite?color=blue)](https://rubygems.org/gems/dev_suite)
[![Gem Downloads](https://img.shields.io/gem/dt/dev_suite?color=blue)](https://rubygems.org/gems/dev_suite)
[![Maintainability](https://api.codeclimate.com/v1/badges/fd83689d39e0f24663fa/maintainability)](https://codeclimate.com/github/patrick204nqh/dev_suite/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fd83689d39e0f24663fa/test_coverage)](https://codeclimate.com/github/patrick204nqh/dev_suite/test_coverage)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=patrick204nqh_dev_suite&metric=alert_status)](https://sonarcloud.io/summary/overall?id=patrick204nqh_dev_suite)
[![Dependencies Status](https://badges.depfu.com/badges/84fefb47a5b99ea19afd20a2aae22e3e/overview.svg)](https://depfu.com/github/patrick204nqh/dev_suite?project_id=44065)
[![Known Vulnerabilities](https://snyk.io/test/github/patrick204nqh/dev_suite/badge.svg)](https://snyk.io/test/github/patrick204nqh/dev_suite)

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

### CLI Commands

DevSuite also provides a command-line interface for various utilities. Below are some general commands:

| Command            | Description                         |
|--------------------|-------------------------------------|
| `devsuite version` | Displays the version of DevSuite    |
| `devsuite help`    | Shows help information for commands |

## Features Overview

### Performance Analysis
Analyze the performance of Ruby code blocks, capturing metrics like execution time and memory usage.

<details>
  <summary>Show more</summary>
  
  **How to Use**:
  ```ruby
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
Visualize the file structure of directories and subdirectories to better understand project organization.

<details>
  <summary>Show more</summary>
  
  **How to Use**:
  ```ruby
  # Define the directory path
  base_path = "/path/to/your/directory"

  # Execute the visualization
  DevSuite::DirectoryTree.visualize(base_path)
  ```

  **CLI Command**:
  DevSuite also provides a command-line interface for directory tree visualization. Use the following command to print the directory tree of the specified path:

  ```sh
  $ devsuite tree [PATH] [OPTIONS]
  ```

  **CLI Options**:
  
  Below is a table describing the available options for the `devsuite tree` command:

  | Option          | Description                                      | Example Usage                                  |
  |-----------------|--------------------------------------------------|------------------------------------------------|
  | `--depth`, `-d` | Limit the depth of the directory tree displayed. | `$ devsuite tree /path --depth 2`              |
  | `--skip-hidden` | Skip hidden files and directories.               | `$ devsuite tree /path --skip-hidden`          |
  | `--skip-types`  | Exclude files of specific types.                 | `$ devsuite tree /path --skip-types .log .tmp` |

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

### Request Logging
Log detailed HTTP requests and responses across different adapters like Net::HTTP and Faraday for debugging and monitoring

<details>
  <summary>Show more</summary>
  
  **How to Use**:
  ```ruby
  DevSuite::RequestLogger.with_logging do 
    # Make an HTTP request using Net::HTTP
    uri = URI('https://jsonplaceholder.typicode.com/posts')
    response = Net::HTTP.get(uri)
  end
  ```

  **Configuration Guide**:
  Customize the request logging behavior by setting configuration options:
  ```ruby
  DevSuite::RequestLogger::Config.configure do |config|
    config.adapters = [:net_http]
    config.settings.set(:log_level, :debug)
    config.settings.set(:log_headers, true)
    config.settings.set(:log_cookies, true)
    config.settings.set(:log_body, true)
  end
  ```

  **Configuration Options**:
  
  Below is a table describing the general configuration options available:

  | Setting        | Description                                           | Default Value | Example Values                     |
  |----------------|-------------------------------------------------------|---------------|------------------------------------|
  | `:adapters`    | List of adapters for which logging is enabled.        | `[:net_http]` | `[:net_http, :faraday]`            |

  **Settings Options**:

  The `settings` key allows you to customize various logging behaviors. Below is a table describing these settings:

  | Setting        | Description                                           | Default Value | Example Values                     |
  |----------------|-------------------------------------------------------|---------------|------------------------------------|
  | `:log_level`   | Set the logging level.                                | `:debug`      | `:info`, `:debug`, `:warn`, `:error` |
  | `:log_headers` | Enable or disable logging of HTTP headers.            | `true`        | `true`, `false`                    |
  | `:log_cookies` | Enable or disable logging of cookies.                 | `true`        | `true`, `false`                    |
  | `:log_body`    | Enable or disable logging of HTTP bodies.             | `true`        | `true`, `false`                    |

  **Sample Output**:
  ```bash
[DEBUG] 🚀 Net::HTTP Request: GET https://jsonplaceholder.typicode.com/posts
[DEBUG] 📄 Headers: {"accept-encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "accept"=>"*/*", "user-agent"=>"Ruby", "host"=>"jsonplaceholder.typicode.com"}
[DEBUG] 🍪 Cookies: None
[DEBUG] ✅ Net::HTTP Response: 200 OK
[DEBUG] 📄 Headers: {"date"=>"Wed, 21 Aug 2024 10:33:59 GMT", "content-type"=>"application/json; charset=utf-8", "transfer-encoding"=>"chunked", "connection"=>"keep-alive", "report-to"=>"{\"group\":\"heroku-nel\",\"max_age\":3600,\"endpoints\":[{\"url\":\"https://nel.heroku.com/reports?ts=1723379558&sid=e11707d5-02a7-43ef-b45e-2cf4d2036f7d&s=LYnyHXQQqBH310%2FAbzjH0MN%2BaFoA6Ntqh94a3%2F5J54E%3D\"}]}", "reporting-endpoints"=>"heroku-nel=https://nel.heroku.com/reports?ts=1723379558&sid=e11707d5-02a7-43ef-b45e-2cf4d2036f7d&s=LYnyHXQQqBH310%2FAbzjH0MN%2BaFoA6Ntqh94a3%2F5J54E%3D", "nel"=>"{\"report_to\":\"heroku-nel\",\"max_age\":3600,\"success_fraction\":0.005,\"failure_fraction\":0.05,\"response_headers\":[\"Via\"]}", "x-powered-by"=>"Express", "x-ratelimit-limit"=>"1000", "x-ratelimit-remaining"=>"999", "x-ratelimit-reset"=>"1723379596", "vary"=>"Origin, Accept-Encoding", "access-control-allow-credentials"=>"true", "cache-control"=>"max-age=43200", "pragma"=>"no-cache", "expires"=>"-1", "x-content-type-options"=>"nosniff", "etag"=>"W/\"6b80-Ybsq/K6GwwqrYkAsFxqDXGC7DoM\"", "via"=>"1.1 vegur", "cf-cache-status"=>"HIT", "age"=>"4620", "server"=>"cloudflare", "cf-ray"=>"8b69f7d4ad941fa4-HKG", "alt-svc"=>"h3=\":443\"; ma=86400"}
[DEBUG] 💻 Response Body: [
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
  ...
]
  ```
</details>

### Workflow Engine
Manage complex workflows consisting of multiple sequential steps, including handling data between steps and supporting dynamic operations like conditionals, loops, and parallel execution.

<details>
  <summary>Show more</summary>

  **How to Use**:
  ```ruby
  workflow = DevSuite::Workflow.create_engine(initial_context)

  # Define steps
  step1 = DevSuite::Workflow.create_step("Step 1") do |ctx|
    ctx.update({ result: "Step 1 Complete" })
  end

  step2 = DevSuite::Workflow.create_step("Step 2") do |ctx|
    puts "Previous Result: #{ctx.get(:result)}"
    ctx.update({ result: "Step 2 Complete" })
  end

  # Chain steps together
  workflow.step(step1).step(step2)

  # Execute workflow
  workflow.execute
  ```

  **Chaining Steps**:
  You can chain multiple steps together to create a workflow:
  ```ruby
  workflow = DevSuite::Workflow.create_engine(initial_context)
  
  step1 = DevSuite::Workflow.create_step("Step 1") { |ctx| ctx.update({ data: 'Data from Step 1' }) }
  step2 = DevSuite::Workflow.create_step("Step 2") { |ctx| puts "Received: #{ctx.get(:data)}" }

  workflow.step(step1)
          .step(step2)
          .execute
  ```

  **Data Handling**:
  Each step in the workflow has access to a shared context, where you can store and retrieve data:
  ```ruby
  workflow = DevSuite::Workflow.create_engine({ some_key: 'initial_value' })

  step1 = DevSuite::Workflow.create_step("Step 1") do |ctx|
    # Retrieve data
    puts ctx.get(:some_key)  # Output: initial_value
    # Set data
    ctx.update({ new_key: 'new_value' })
  end

  step2 = DevSuite::Workflow.create_step("Step 2") do |ctx|
    # Use updated data
    puts ctx.get(:new_key)  # Output: new_value
  end

  workflow.step(step1).step(step2).execute
  ```

  **Conditional Execution**:
  Conditionally execute steps based on logic defined in the workflow context:
  ```ruby
  conditional_step = DevSuite::Workflow.create_conditional_step("Conditional Step", condition: ->(ctx) { ctx.get(:result) == "Step 1 Complete" }) do |ctx|
    puts "Condition met! Executing conditional step."
    ctx.update({ result: "Conditional Step Executed" })
  end

  workflow.step(conditional_step).execute
  ```

  **Parallel Execution**:
  You can execute multiple steps in parallel:
  ```ruby
  parallel_step = DevSuite::Workflow.create_parallel_step("Parallel Step") do |ctx|
    [
      ->(ctx) { ctx.update({ task1: "Task 1 done" }) },
      ->(ctx) { ctx.update({ task2: "Task 2 done" }) }
    ]
  end

  workflow.step(parallel_step).execute
  ```

  **Save and Load Context**:
  Save the workflow's context to a file and reload it for later use:
  ```ruby
  # Saving context to a YAML file
  workflow = DevSuite::Workflow.create_engine({ user: 'John' })
  workflow.step(DevSuite::Workflow.create_step("Example") { |ctx| ctx.update({ status: 'completed' }) })
  workflow.execute

  File.open('context.yml', 'w') { |file| file.write(YAML.dump(workflow.context.data)) }

  # Loading context from a YAML file
  loaded_data = YAML.load_file('context.yml')
  workflow = DevSuite::Workflow.create_engine(loaded_data)
  ```

  **Looping**:
  You can loop steps in the workflow, for instance, if you need to repeat a step multiple times:
  ```ruby
  loop_step = DevSuite::Workflow.create_loop_step("Repeat 5 Times", iterations: 5) do |ctx|
    count = ctx.get(:count) || 0
    ctx.update({ count: count + 1 })
    puts "Iteration: #{ctx.get(:count)}"
  end

  workflow.step(loop_step).execute
  ```

  **Using the Store**:
  By default, the workflow context provides access to an integrated store via ctx.store. You can save and retrieve data across steps:
  ```ruby
  # Using the store in the workflow
  workflow = DevSuite::Workflow.create_engine(
    {},
    driver: :file,
    path: "tmp/workflow.yml",
  )
  step = DevSuite::Workflow.create_step("Store Example") do |ctx|
    ctx.store.set(:step_result, "Step 1 Completed")
  end

  workflow.step(step).execute

  # Fetch data from the store
  puts ctx.store.fetch(:step_result)  # Output: Step 1 Completed
  ```

  **Sample Output**:
  ```bash
  Step 1 executed: result => Step 1 Complete
  Step 2 executed: Previous Result: Step 1 Complete
  Task 1 done
  Task 2 done
  Iteration: 1
  Iteration: 2
  ...
  Condition met! Executing conditional step.
  Store contains: { name: "John Doe", age: 30 }
  Step 1 Completed
  ```

</details>

### Method Tracer
Trace all method calls within a specific block of code, including optional logging of parameters, results, and execution time. This feature is useful for debugging, profiling, and understanding the flow of method calls in your code.

<details>
  <summary>Show more</summary>
  
  **How to Use**:
  ```ruby
  # Sample class for demonstration
  class MathOperations
    def add(a, b)
      multiply(a, b) + 3
    end

    def multiply(a, b)
      a * b
    end

    def greet(name)
      "Hello, #{name}!"
    end
  end

  # Using MethodTracer to trace method calls
  DevSuite::MethodTracer.trace(show_params: true, show_results: true, show_execution_time: true) do
    math = MathOperations.new
    result = math.add(5, 3)
    puts result
    
    greeting = math.greet("Ruby")
    puts greeting  # Should print the greeting
  end
  ```

  **Configuration Guide**:
  Customize the method tracing behavior by setting configuration options:
  ```ruby
  DevSuite::MethodTracer.trace(
    show_params: true,
    show_results: true,
    show_execution_time: true,
    max_depth: 2
  ) do
    # Code block to trace
  end
  ```

  **Configuration Options**:
  
  Below is a table describing the available options for `MethodTracer`:

  | Option               | Description                                         | Default Value | Example Values            |
  |----------------------|-----------------------------------------------------|---------------|---------------------------|
  | `:show_params`       | Enables logging of method parameters.               | `false`       | `true`, `false`           |
  | `:show_results`      | Logs the return values of the methods.              | `false`       | `true`, `false`           |
  | `:show_execution_time` | Logs the execution time for each method.          | `false`       | `true`, `false`           |
  | `:max_depth`         | Limits the depth of method calls to log.            | `nil`         | `1`, `2`, `3`, ...        |

  **Sample Output**:
  ```bash
   🚀 #depth:1 > MathOperations#add at (irb):2 (5, 3)
      🚀 #depth:2 > MathOperations#multiply at (irb):6 (5, 3)
      🏁 #depth:2 < MathOperations#multiply #=> 15 at (irb):8 in 0.02ms
   🏁 #depth:1 < MathOperations#add #=> 23 at (irb):4 in 7.35ms
   🚀 #depth:1 > MathOperations#greet at (irb):10 ("Ruby")
   🏁 #depth:1 < MathOperations#greet #=> "Hello, Ruby!" at (irb):12 in 0.02ms
Hello, Ruby!
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
