# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create a workflow with multiple sub-steps
engine = DevSuite::Workflow::Engine.new

composite_step = DevSuite::Workflow.create_composite_step("Composite Task")

# Add sub-steps
sub_step1 = DevSuite::Workflow.create_step("Sub-Step 1") do |context|
  puts "Executing Sub-Step 1"
end
sub_step2 = DevSuite::Workflow.create_step("Sub-Step 2") do |context|
  puts "Executing Sub-Step 2"
end

composite_step.step(sub_step1).step(sub_step2)
engine.step(composite_step)
engine.execute
