# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      class ExecutionTime < Base
        attr_reader :stats

        def run(&block)
          result = nil
          timing = ::Benchmark.measure { result = yield }
          @stats = calculate_stats(timing)
          result
        end

        private

        def calculate_stats(timing)
          {
            real: timing.real,
            utime: timing.utime,
            stime: timing.stime,
            total: timing.total,
          }
        end
      end
    end
  end
end
