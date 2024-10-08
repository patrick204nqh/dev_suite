# frozen_string_literal: true

module DevSuite
  module Workflow
    class Engine
      attr_reader :steps, :context

      def initialize(initial_context = {}, **options)
        @steps = []
        @context = StepContext.new(initial_context, **options)
      end

      # Add steps to the engine
      def step(step)
        @steps << step
        self # Return the current engine instance to support chaining
      end

      # Execute the workflow
      def execute
        @steps.each do |step|
          step.run(@context)
        end
      end
    end
  end
end
