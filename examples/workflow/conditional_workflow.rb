# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Create a conditional workflow
engine = DevSuite::Workflow::Engine.new(user: "Bob", role: "admin")

# Add a conditional step
conditional_step = DevSuite::Workflow.create_conditional_step("Admin Greeting", ->(ctx) {
  ctx.get(:role) == "admin"
}) do |context|
  puts "Welcome Admin, #{context.get(:user)}!"
end

engine.step(conditional_step)
engine.execute
