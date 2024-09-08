# frozen_string_literal: true

module DevSuite
  module Workflow
    class Engine
      attr_reader :steps, :context

      def initialize(context = {}, **options)
        @steps = []
        @context = StepContext.new(context, **options)
      end

      # Add steps to the engine
      def add_step(step)
        @steps << step
        self # Return the current engine instance to support chaining
      end

      # Execute the workflow
      def execute
        @steps.each do |step|
          step.execute(@context)
        end
      end
    end
  end
end
