# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Conditional < Base
        def initialize(name, condition, &action)
          super(name, &action)
          @condition = condition
        end

        # Only execute if the condition is met
        def execute(context)
          if @condition.call(context)
            super
          else
            Logger.log(@name, "Skipped due to condition")
          end
        end
      end
    end
  end
end
