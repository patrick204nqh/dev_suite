# frozen_string_literal: true

require "benchmark"
require_relative "base"

module DevSuite
  module Performance
    module Profiler
      class Benchmark < Base
        def run(&block)
          ::Benchmark.measure do
            block.call
          end
        end
      end
    end
  end
end
