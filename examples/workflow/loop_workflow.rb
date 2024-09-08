# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create a workflow with a looping step
engine = DevSuite::Workflow::Engine.new(iteration_count: 0)

# Add a loop step
loop_step = DevSuite::Workflow.create_loop_step("Repeat Task", 3) do |context|
  iteration = context.get(:iteration_count) + 1
  context.update({ iteration_count: iteration })
  puts "Iteration #{iteration}"
end

engine.add_step(loop_step)
engine.execute
