# frozen_string_literal: true

require "spec_helper"
require "stringio"

RSpec.describe(DevSuite::MethodTracer::Tracer) do
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
    context "with methods at the same level" do
      it "logs method calls up to the max depth of 3" do
        tracer = DevSuite::MethodTracer::Tracer.new(max_depth: 3, show_params: true, show_results: true)

        tracer.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        log_output = output.string

        # Ensure that method calls up to depth 3 are logged
        expect(log_output).to(include_without_color("#depth:1 > ComplexClass#process_data"))
        expect(log_output).to(include_without_color("#depth:2 > ComplexClass#perform_operations_and_log"))
        expect(log_output).to(include_without_color("#depth:3 > ComplexClass#perform_operations"))
        expect(log_output).to(include_without_color("#depth:3 > ComplexClass#log_results"))
      end
    end

    context "with max_depth option" do
      it "logs method calls only up to the max depth" do
        tracer = DevSuite::MethodTracer::Tracer.new(max_depth: 2, show_params: true, show_results: true)

        tracer.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        log_output = output.string

        # Ensure that the calls beyond the max_depth are not logged
        expect(log_output).to(include_without_color("#depth:1 > ComplexClass#process_data"))
        expect(log_output).to(include_without_color("#depth:2 > ComplexClass#validate_data"))
        expect(log_output).not_to(include_without_color("#depth:3 > ComplexClass#data_present?"))
        expect(log_output).not_to(include_without_color("#depth:4 > ComplexClass#log_results"))
      end

      it "logs method calls up to the max depth of 3" do
        tracer = DevSuite::MethodTracer::Tracer.new(max_depth: 3, show_params: true, show_results: true)

        tracer.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        log_output = output.string

        # Ensure that method calls up to depth 3 are logged
        expect(log_output).to(include_without_color("#depth:1 > ComplexClass#process_data"))
        expect(log_output).to(include_without_color("#depth:2 > ComplexClass#validate_data"))
        expect(log_output).to(include_without_color("#depth:3 > ComplexClass#data_present?"))
        expect(log_output).not_to(include_without_color("#depth:4 > ComplexClass#log_results"))
      end

      it "resets depth correctly after returning from a deep call" do
        tracer = DevSuite::MethodTracer::Tracer.new(max_depth: 3)

        tracer.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        log_output = output.string

        # Check that depth resets correctly
        expect(tracer.current_depth).to(eq(0))
      end
    end

    context "with nested method calls and max depth" do
      it "logs return values for methods up to the max depth" do
        tracer = DevSuite::MethodTracer::Tracer.new(max_depth: 2, show_results: true)

        tracer.trace do
          complex = ComplexClass.new(value: 50)
          complex.process_data
        end

        log_output = output.string

        # Ensure that the return values are logged up to max depth
        expect(log_output).to(include_without_color("#depth:2 < ComplexClass#validate_data"))
        expect(log_output).not_to(include_without_color("#depth:3 < ComplexClass#data_present?"))
      end
    end

    context "with show_params and show_results" do
      it "logs method parameters and results if enabled" do
        tracer = DevSuite::MethodTracer::Tracer.new(show_params: true, show_results: true)

        tracer.trace do
          dummy = GreetingClass.new
          dummy.say_hello("RSpec")
        end

        log_output = output.string

        expect(log_output).to(include_without_color('("RSpec")'))
        expect(log_output).to(include_without_color('#=> "Hello, RSpec!"'))
      end

      it "does not log parameters and results if disabled" do
        tracer = DevSuite::MethodTracer::Tracer.new(show_params: false, show_results: false)

        tracer.trace do
          dummy = GreetingClass.new
          dummy.say_hello("RSpec")
        end

        log_output = output.string

        expect(log_output).not_to(include_without_color('("RSpec")'))
        expect(log_output).not_to(include_without_color('#=> "Hello, RSpec!"'))
      end
    end
  end
end
