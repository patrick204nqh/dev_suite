# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Composite < Base
        def initialize(name:)
          super
          @steps = []
        end

        # Add steps to the composite
        def step(step)
          @steps << step
          self
        end

        # Override execute to run all steps in sequence
        def run(context)
          @steps.each do |step|
            step.run(context)
          end
        end
      end
    end
  end
end
