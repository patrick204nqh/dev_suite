# frozen_string_literal: true

require_relative "../lib/dev_suite"

# Initialize a workflow context
initial_context = {
  user: "John Doe",
  role: "admin",
  iteration_count: 0,
}

# Step 1: Define a basic sequential step
basic_step = DevSuite::Workflow.create_step("Basic Step") do |ctx|
  ctx.update(basic_result: "Basic Step Completed")
  puts "Basic Step executed. Result: #{ctx.get(:basic_result)}"
end

# Step 2: Define a conditional step
conditional_step = DevSuite::Workflow.create_conditional_step("Conditional Step", ->(ctx) {
  ctx.get(:role) == "admin"
}) do |ctx|
  ctx.update(conditional_result: "Conditional Step Executed for Admin")
  puts "Conditional Step executed for Admin."
end

# Step 3: Define a loop step (repeats 3 times)
loop_step = DevSuite::Workflow.create_loop_step("Loop Step", 3) do |ctx|
  iteration = ctx.get(:iteration_count) || 0
  iteration += 1
  ctx.update(iteration_count: iteration)
  puts "Loop Step - Iteration: #{iteration}"
end

# Step 4: Define a parallel step
parallel_step = DevSuite::Workflow.create_parallel_step("Parallel Step") do |ctx|
  [
    ->(context) {
      context.update(task1_result: "Task 1 Done")
      puts "Parallel Step: Task 1 executed"
    },
    ->(context) {
      context.update(task2_result: "Task 2 Done")
      puts "Parallel Step: Task 2 executed"
    },
  ]
end

# Step 5: Define a composite step (combines two basic steps)
composite_step = DevSuite::Workflow.create_composite_step("Composite Step")
step1 = DevSuite::Workflow.create_step("Sub-Step 1") do |ctx|
  ctx.update(sub_step1_result: "Sub-Step 1 Executed")
  puts "Sub-Step 1 executed."
end
step2 = DevSuite::Workflow.create_step("Sub-Step 2") do |ctx|
  ctx.update(sub_step2_result: "Sub-Step 2 Executed")
  puts "Sub-Step 2 executed."
end
composite_step.add_step(step1).add_step(step2)

# Step 6: Test Store integration (store data and retrieve it)
store_step = DevSuite::Workflow.create_step("Store Step") do |ctx|
  ctx.store.set(:workflow_result, "Workflow Completed")
  puts "Data stored in context store."
end

# Define the workflow engine and add all the steps
workflow = DevSuite::Workflow.create_engine(initial_context)
workflow.add_step(basic_step)
  .add_step(conditional_step)
  .add_step(loop_step)
  .add_step(parallel_step)
  .add_step(composite_step)
  .add_step(store_step)

# Execute the workflow
puts "Executing workflow..."
workflow.execute

# Test store retrieval after execution
puts "Retrieving data from store: #{workflow.context.store.fetch(:workflow_result)}"
