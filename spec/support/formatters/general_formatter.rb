# frozen_string_literal: true

require "rspec/core/formatters/base_text_formatter"

class GeneralFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register(self, :example_started, :example_passed, :example_failed, :example_pending)

  # Called at the start of each example
  def example_started(notification)
    output.puts "\n🟡 Starting: #{colorize_text(notification.example.full_description, :yellow)}"
  end

  # Called when an example passes
  def example_passed(notification)
    output.puts "✅ Passed: #{colorize_text(notification.example.full_description, :green)}"
    log_example_metadata(notification.example)
  end

  # Called when an example fails
  def example_failed(notification)
    output.puts "❌ Failed: #{colorize_text(notification.example.full_description, :red)}"
    log_example_metadata(notification.example)
    log_failure_details(notification)
  end

  # Called when an example is pending
  def example_pending(notification)
    output.puts "⏳ Pending: #{colorize_text(notification.example.full_description, :blue)}"
  end

  private

  # Utility method to add colors to text
  def colorize_text(text, color)
    colors = { red: 31, green: 32, yellow: 33, blue: 34 }
    "\e[#{colors[color]}m#{text}\e[0m"
  end

  # Logs additional metadata if available
  def log_example_metadata(example)
    if example.metadata[:response]
      response = example.metadata[:response]
      output.puts "  ↪ Status Code: #{response.status}"
      output.puts "  ↪ Response Body: #{pretty_print_json(response.body)}"
    end

    # Additional metadata can be logged here
    if example.metadata[:execution_time]
      output.puts "  ⏱ Execution Time: #{example.metadata[:execution_time]} ms"
    end
  end

  # Logs detailed failure information
  def log_failure_details(notification)
    exception = notification.exception
    output.puts "  ↪ Failure: #{exception.message}"
    output.puts "  ↪ Location: #{exception.backtrace.first}"
  end

  # Utility method to pretty print JSON
  def pretty_print_json(json)
    JSON.pretty_generate(JSON.parse(json))
  rescue
    json
  end
end

RSpec.configure do |config|
  config.add_formatter(GeneralFormatter)
end
