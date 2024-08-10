# frozen_string_literal: true

require_relative "base"
require_relative "../data/memory_usage"

module DevSuite
  module Performance
    module Profiler
      class Memory < Base
        attr_reader :max_memory, :min_memory, :average_memory

        def initialize
          super
          @memory_usage = Data::MemoryUsage.new
          @memory_points = []
        end

        def profile(&block)
          yield
          record_memory
        end

        def stats(before, after)
          memory_used = after - before
          @average_memory = @memory_points.sum / @memory_points.size
          {
            before: before,
            after: after,
            used: memory_used,
            max: @memory_points.max,
            min: @memory_points.min,
            avg: @average_memory,
          }
        end

        private

        def record_memory
          current_mem = @memory_usage.current
          @memory_points << current_mem
        end
      end
    end
  end
end
