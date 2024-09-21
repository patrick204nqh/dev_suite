# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Conditional < Base
        def initialize(name:, condition:, &action)
          super(name: name, &action)
          @condition = condition
        end

        # Only execute if the condition is met
        def run(context)
          if @condition.call(context)
            super
          else
            Utils::Logger.log("Step: #{@name} - Skipped due to condition", level: :info)
          end
        end
      end
    end
  end
end
