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

          # If the result is nil or false, stop execution chain
          return unless result

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
        rescue StandardError => e
          Utils::Logger.log("Step: #{@name} - Error: #{e}", level: :error)
          false
        end

        # Update the context with the result of the action
        # If the context is cleared, the result is preserved and used to update the context
        def update_context(context, result)
          # Store the result before clearing the context to avoid losing data
          stored_result = result.dup

          # Clear the context
          context.clear

          # Update the context with the stored result
          context.update(stored_result)
        end

        # Execute the next step if it exists
        def execute_next_step(context)
          @next_step&.execute(context)
        end
      end
    end
  end
end
