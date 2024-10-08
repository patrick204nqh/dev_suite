# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create the workflow engine with an initial context
engine = DevSuite::Workflow.create_engine(
  {
    user: "Alice",
    role: "admin",
    iteration_count: 0,
  },
  driver: :file,
  path: "tmp/workflow_store.json",
)

# Step 1: Create a basic step to greet the user
greet_step = DevSuite::Workflow.create_step("Greet User") do |context|
  puts "Hello, #{context.get(:user)}!"
end

# Step 2: Create a conditional step to greet only admins
admin_step = DevSuite::Workflow.create_conditional_step("Admin Greeting", condition: ->(ctx) {
  ctx.get(:role) == "admin"
}) do |context|
  puts "Welcome, Admin #{context.get(:user)}!"
end

# Step 3: Create a loop step that repeats 3 times
loop_step = DevSuite::Workflow.create_loop_step("Loop Step", iterations: 3) do |ctx|
  iteration = ctx.get(:iteration_count) + 1
  ctx.update({ iteration_count: iteration })
  puts "Iteration #{iteration} completed."
end

# Step 4: Create a parallel step to run two tasks simultaneously
parallel_step = DevSuite::Workflow.create_parallel_step("Parallel Task") do |context|
  [
    ->(ctx) { puts "Task 1 executed" },
    ->(ctx) { puts "Task 2 executed" },
  ]
end

# Step 5: Create a composite step that combines two sub-steps
composite_step = DevSuite::Workflow.create_composite_step("Composite Task")

# Sub-Step 1
sub_step1 = DevSuite::Workflow.create_step("Sub-Step 1") do |context|
  puts "Executing Sub-Step 1"
end

# Sub-Step 2
sub_step2 = DevSuite::Workflow.create_step("Sub-Step 2") do |context|
  puts "Executing Sub-Step 2"
end

# Add sub-steps to the composite step
composite_step.step(sub_step1).step(sub_step2)

# Step 6: A step to store the final workflow result
store_step = DevSuite::Workflow.create_step("Store Result") do |context|
  context.store.set(:workflow_result, "Workflow Completed")
  puts "Result stored in context."
end

# Add all steps to the workflow engine
engine.step(greet_step)
  .step(admin_step)
  .step(loop_step)
  .step(parallel_step)
  .step(composite_step)
  .step(store_step)

# Execute the workflow
puts "Executing workflow..."
engine.execute

# Retrieve the result from the context store after execution
puts "Final result from context store: #{engine.context.store.fetch(:workflow_result)}"
