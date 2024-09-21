# frozen_string_literal: true

module DevSuite
  module Workflow
    require_relative "step_context"
    require_relative "step"
    require_relative "engine"

    class << self
      def create_engine(context = {}, **options)
        Engine.new(context, **options)
      end

      def create_step(name, type: :base, **args, &block)
        Step.build_component(type, name: name, **args, &block)
      end

      def create_base_step(name, &block)
        create_step(name, type: :base, &block)
      end

      def create_parallel_step(name, &block)
        create_step(name, type: :parallel, &block)
      end

      def create_conditional_step(name, condition:, &block)
        create_step(name, type: :conditional, condition: condition, &block)
      end

      def create_loop_step(name, iterations:, &block)
        create_step(name, type: :loop, iterations: iterations, &block)
      end

      def create_composite_step(name)
        create_step(name, type: :composite)
      end
    end
  end
end
