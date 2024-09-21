# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create a workflow with parallel tasks
engine = DevSuite::Workflow::Engine.new

parallel_step = DevSuite::Workflow.create_parallel_step("Parallel Task") do |context|
  [
    ->(ctx) { puts "Task 1 executed" },
    ->(ctx) { puts "Task 2 executed" },
  ]
end

engine.step(parallel_step)
engine.execute
