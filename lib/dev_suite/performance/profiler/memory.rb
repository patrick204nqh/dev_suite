# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      class Memory < Base
        attr_reader :stats

        def initialize
          super
          @memory_usage = Data::MemoryUsage.new
          @memory_points = []
        end

        def run(&block)
          before_memory = record_memory
          result = yield
          after_memory = record_memory

          @stats = calculate_stats(before_memory, after_memory)
          result
        end

        private

        def record_memory
          current_mem = @memory_usage.current
          @memory_points << current_mem
          current_mem
        end

        def calculate_stats(before, after)
          memory_used = after - before
          average_memory = @memory_points.sum / @memory_points.size

          {
            before: before,
            after: after,
            used: memory_used,
            max: @memory_points.max,
            min: @memory_points.min,
            avg: average_memory,
          }
        end
      end
    end
  end
end
