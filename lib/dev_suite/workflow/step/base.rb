# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Base < Utils::Construct::Component::Base
        attr_accessor :name, :next_step

        def initialize(name:, &action)
          super()
          @name = name
          @action = action
          @next_step = nil
        end

        # Executes the step and moves to the next step
        def run(context)
          result = perform_action(context)
          Utils::Logger.log("Step: #{@name} - Result: #{result}", level: :info)

          # If the result is nil or false, stop execution chain
          return unless result

          update_context(context, result)
          run_next_step(context)
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

        # Update the context with the result of the action (without clearing it)
        def update_context(context, result)
          context.update(result)
        end

        # Execute the next step if it exists
        def run_next_step(context)
          @next_step&.run(context)
        end
      end
    end
  end
end
