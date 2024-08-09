# frozen_string_literal: true

require_relative "base_profiler"
require_relative "../data/cpu_usage"

module DevSuite
  module Performance
    module Profiling
      class CPUProfiler < BaseProfiler
        def initialize
          super
          @cpu_usage = Data::CPUUsage.new
        end

        def profile
          @cpu_usage.record
        end

        def stats
          { avg: @cpu_usage.average, peak: @cpu_usage.peak }
        end
      end
    end
  end
end
