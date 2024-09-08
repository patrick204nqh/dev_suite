# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Composite < Base
        def initialize(name)
          super
          @steps = []
        end

        # Add steps to the composite
        def add_step(step)
          @steps << step
          self
        end

        # Override execute to run all steps in sequence
        def execute(context)
          @steps.each do |step|
            step.execute(context)
          end
        end
      end
    end
  end
end
