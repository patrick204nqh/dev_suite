# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create a basic workflow
engine = DevSuite::Workflow::Engine.new(user: "Alice")

# Add a basic step
basic_step = DevSuite::Workflow.create_step("Greet User") do |context|
  puts "Hello, #{context.get(:user)}!"
end

engine.step(basic_step)
engine.execute
