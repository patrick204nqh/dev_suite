# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Loop < Base
        def initialize(name, iterations, &action)
          super(name, &action)
          @iterations = iterations
        end

        def execute(context)
          @iterations.times do |i|
            Utils::Logger.log("Step: #{@name} - Iteration: #{i + 1}", level: :info)
            super(context)
          end
        end
      end
    end
  end
end
