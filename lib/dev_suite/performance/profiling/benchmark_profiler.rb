# frozen_string_literal: true

require "benchmark"
require_relative "base_profiler"

module DevSuite
  module Performance
    module Profiling
      class BenchmarkProfiler < BaseProfiler
        def run(&block)
          Benchmark.measure do
            block.call
          end
        end
      end
    end
  end
end
