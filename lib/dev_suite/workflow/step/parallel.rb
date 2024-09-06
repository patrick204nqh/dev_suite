# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      class Parallel < Base
        # Executes multiple tasks in parallel using threads
        def execute(context)
          tasks = @action.call(context)
          threads = tasks.map do |task|
            Thread.new { task.call(context) }
          end
          threads.each(&:join)
        end
      end
    end
  end
end
