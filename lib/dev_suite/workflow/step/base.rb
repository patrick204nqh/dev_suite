# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Base
        attr_accessor :name, :next_step

        def initialize(name, &action)
          @name = name
          @action = action
          @next_step = nil
        end

        # Executes the step and moves to the next step
        def execute(context)
          result = perform_action(context)
          Utils::Logger.log("Step: #{@name} - Result: #{result}", level: :info)
          update_context(context, result)
          execute_next_step(context)
        end

        # Chain the next step
        def next(step)
          @next_step = step
          step
        end

        private

        # Perform the action associated with this step
        def perform_action(context)
          @action.call(context)
        end

        # Update the context with the result of the action
        def update_context(context, result)
          context.update(result)
        end

        # Execute the next step if it exists
        def execute_next_step(context)
          @next_step&.execute(context)
        end
      end
    end
  end
end
