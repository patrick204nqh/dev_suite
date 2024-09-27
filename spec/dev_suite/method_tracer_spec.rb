# frozen_string_literal: true

require "spec_helper"
require "stringio"

# Dummy classes for testing
class DummyClass
  def say_hello(name)
    "Hello, #{name}!"
  end
end

class NestedDummyClass
  def greet
    dummy = DummyClass.new
    dummy.say_hello("RSpec")
  end
end

RSpec.describe(DevSuite::MethodTracer) do
  let(:output) { StringIO.new }

  before do
    # Redirect stdout to capture output
    allow($stdout).to(receive(:write) { |message| output.write(message) })
  end

  after do
    # Reset the captured output
    output.truncate(0)
    output.rewind
  end

  describe ".trace" do
    it "logs method calls with correct depth and file/line information" do
      DevSuite::MethodTracer.trace(show_params: true, show_results: true, show_execution_time: true) do
        nested_dummy = NestedDummyClass.new
        nested_dummy.greet
      end

      log_output = output.string

      # Check if method calls are logged with depth information
      expect(log_output).to(include("#depth:1 > NestedDummyClass#greet"))
      expect(log_output).to(include("#depth:2 > DummyClass#say_hello"))

      # Check if return values are logged
      expect(log_output).to(include('#depth:2 < DummyClass#say_hello #=> "Hello, RSpec!"'))

      # Verify method source location (line numbers might need adjusting based on your code)
      expect(log_output).to(match(/at .*method_tracer_spec.rb:\d+/))
    end

    it "logs parameters if show_params is true" do
      DevSuite::MethodTracer.trace(show_params: true) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).to(include("say_hello at"))
      expect(log_output).to(include('("RSpec")'))
    end

    it "does not log parameters if show_params is false" do
      DevSuite::MethodTracer.trace(show_params: false) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).not_to(include('("RSpec")'))
    end

    it "logs return values if show_results is true" do
      DevSuite::MethodTracer.trace(show_results: true) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).to(include('#=> "Hello, RSpec!"'))
    end

    it "does not log return values if show_results is false" do
      DevSuite::MethodTracer.trace(show_results: false) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).not_to(include('#=> "Hello, RSpec!"'))
    end

    it "logs execution time if show_execution_time is true" do
      DevSuite::MethodTracer.trace(show_execution_time: true) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).to(match(/in \d+\.\d+ms/))
    end

    it "does not log execution time if show_execution_time is false" do
      DevSuite::MethodTracer.trace(show_execution_time: false) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).not_to(match(/in \d+\.\d+ms/))
    end

    it "handles nested method calls and logs correct depth" do
      DevSuite::MethodTracer.trace(show_params: true, show_results: true) do
        nested_dummy = NestedDummyClass.new
        nested_dummy.greet
      end

      log_output = output.string

      # Ensure the correct depth levels are logged
      expect(log_output).to(include("#depth:1 > NestedDummyClass#greet"))
      expect(log_output).to(include("#depth:2 > DummyClass#say_hello"))
    end

    it "only traces methods within the given block" do
      DevSuite::MethodTracer.trace(show_params: true) do
        dummy = DummyClass.new
        dummy.say_hello("RSpec")
      end

      log_output = output.string
      expect(log_output).to(include("say_hello"))

      # Outside the tracing block, no logs should be present
      output.truncate(0)
      output.rewind

      dummy = DummyClass.new
      dummy.say_hello("Outside")
      expect(output.string).to(be_empty)
    end
  end
end
