# frozen_string_literal: true

require "json"
require "rspec/core/formatters/base_text_formatter"

class GeneralFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register(self, :example_passed, :example_failed, :example_pending, :start, :dump_summary)

  def initialize(output)
    super
    @output = output
  end

  def example_passed(notification)
    log_example_metadata(notification.example)
    output.puts "✅ Passed: #{notification.example.full_description}"
  end

  def example_failed(notification)
    log_example_metadata(notification.example)
    log_failure_details(notification)
    output.puts "❌ Failed: #{notification.example.full_description}"
  end

  def example_pending(notification)
    log_example_metadata(notification.example)
    output.puts "🟡 Pending: #{notification.example.full_description}"
  end

  def start(notification)
    output.puts "Randomized with seed #{RSpec.configuration.seed}"
  end

  def dump_summary(summary)
    output.puts "\nFinished in #{summary.duration.round(5)} seconds (files took #{summary.load_time.round(5)} seconds to load)"
    output.puts "#{summary.examples.size} examples, #{summary.failed_examples.size} failures"
  end

  private

  attr_reader :output

  def log_example_metadata(example)
    if example.metadata[:response]
      response = example.metadata[:response]
      output.puts "  ↪ Status Code: #{response.status}"
      output.puts "  ↪ Response Body: #{pretty_print_json(response.body)}"
    end

    if example.metadata[:execution_time]
      output.puts "  ⏱ Execution Time: #{example.metadata[:execution_time]} ms"
    end
  end

  def log_failure_details(notification)
    exception = notification.exception
    output.puts "  ↪ Failure: #{exception.message}"
    output.puts "  ↪ Location: #{exception.backtrace&.first}"
  end

  def pretty_print_json(json)
    JSON.pretty_generate(JSON.parse(json))
  rescue JSON::ParserError
    json
  end
end

RSpec.configure do |config|
  # Clear existing formatters to prevent duplication
  config.formatters.clear

  # Add the custom formatter only once
  config.add_formatter(GeneralFormatter)
end
