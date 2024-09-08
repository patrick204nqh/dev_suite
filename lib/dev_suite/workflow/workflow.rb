# frozen_string_literal: true

module DevSuite
  module Workflow
    require_relative "logger"
    require_relative "step_context"
    require_relative "step"
    require_relative "engine"

    class << self
      def create_engine(context = {})
        Engine.new(context)
      end

      def create_step(name, &block)
        Step::Base.new(name, &block)
      end

      def create_parallel_step(name, &block)
        Step::Parallel.new(name, &block)
      end

      def create_conditional_step(name, condition, &block)
        Step::Conditional.new(name, condition, &block)
      end

      def create_loop_step(name, iterations, &block)
        Step::Loop.new(name, iterations, &block)
      end

      def create_composite_step(name)
        Step::Composite.new(name)
      end
    end
  end
end
