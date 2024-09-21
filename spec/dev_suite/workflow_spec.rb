# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Workflow) do
  let(:context_data) { { user_id: 123 } }
  let(:engine) { described_class.create_engine(context_data) }

  describe ".create_engine" do
    it "creates a new workflow engine" do
      expect(engine).to(be_a(DevSuite::Workflow::Engine))
      expect(engine.context.data[:user_id]).to(eq(123))
    end
  end

  describe ".create_step" do
    it "creates a base step" do
      step = described_class.create_step("Test Step") do |ctx|
        ctx.update(test: "step executed")
        ctx.data
      end

      engine.step(step)
      engine.execute

      expect(engine.context.get(:test)).to(eq("step executed"))
    end
  end

  describe ".create_parallel_step" do
    it "creates a parallel step and executes multiple actions concurrently" do
      parallel_step = described_class.create_parallel_step("Parallel Step") do |ctx|
        [
          ->(ctx) {
            ctx.update(task1: "task 1 completed")
            ctx.data
          },
          ->(ctx) {
            ctx.update(task2: "task 2 completed")
            ctx.data
          },
        ]
      end

      engine.step(parallel_step)
      engine.execute

      expect(engine.context.get(:task1)).to(eq("task 1 completed"))
      expect(engine.context.get(:task2)).to(eq("task 2 completed"))
    end
  end

  describe ".create_conditional_step" do
    CONDITION_MET_MESSAGE = "condition met"

    it "executes the step only if the condition is met" do
      conditional_step = described_class.create_conditional_step(
        "Conditional Step",
        condition: ->(ctx) {
          ctx.get(:user_id) == 123
        },
      ) do |ctx|
        ctx.update(test: CONDITION_MET_MESSAGE)
        ctx.data
      end

      engine.step(conditional_step)
      engine.execute

      expect(engine.context.get(:test)).to(eq(CONDITION_MET_MESSAGE))
    end

    it "skips the step if the condition is not met" do
      conditional_step = described_class.create_conditional_step(
        "Conditional Step",
        condition: ->(ctx) {
          ctx.get(:user_id) != 123
        },
      ) do |ctx|
        ctx.update(test: CONDITION_MET_MESSAGE)
        ctx.data
      end

      engine.step(conditional_step)
      engine.execute

      expect(engine.context.get(:test)).to(be_nil)
    end
  end

  describe ".create_loop_step" do
    it "executes the step multiple times based on the iteration count" do
      iterations = 3
      loop_step = described_class.create_loop_step("Loop Step", iterations: iterations) do |ctx|
        iteration = ctx.get(:iteration) || 0
        ctx.update(iteration: iteration + 1)
        ctx.data
      end

      engine.step(loop_step)
      engine.execute

      expect(engine.context.get(:iteration)).to(eq(iterations))
    end
  end

  describe ".create_composite_step" do
    it "executes multiple steps within a composite step" do
      composite_step = described_class.create_composite_step("Composite Step")
      step1 = described_class.create_step("Sub-Step 1") do |ctx|
        ctx.update(sub1: "Sub-Step 1 executed")
        ctx.data
      end
      step2 = described_class.create_step("Sub-Step 2") do |ctx|
        ctx.update(sub2: "Sub-Step 2 executed")
        ctx.data
      end

      composite_step.step(step1).step(step2)

      engine.step(composite_step)
      engine.execute

      expect(engine.context.get(:sub1)).to(eq("Sub-Step 1 executed"))
      expect(engine.context.get(:sub2)).to(eq("Sub-Step 2 executed"))
    end
  end
end
