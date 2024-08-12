# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      require_relative "profiler/base"
      require_relative "profiler/execution_time"
      require_relative "profiler/memory"

      class << self
        def create(profiler)
          case profiler
          when :execution_time
            ExecutionTime.new
          when :memory
            Memory.new
          else
            raise ArgumentError, "Invalid profiler: #{profiler}"
          end
        end

        def create_multiple(profilers)
          profilers.map { |profiler| create(profiler) }
        end
      end
    end
  end
end
