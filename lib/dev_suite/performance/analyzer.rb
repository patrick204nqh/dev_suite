# frozen_string_literal: true

require_relative "reporting/report_generator"
require_relative "profiling/benchmark_profiler"
require_relative "profiling/memory_profiler"
require_relative "profiling/cpu_profiler"

module DevSuite
  module Performance
    class Analyzer
      def initialize(description: "Block")
        @description = description
        @cpu_profiler = Profiling::CPUProfiler.new
        @benchmark_profiler = Profiling::BenchmarkProfiler.new
        @memory_profiler = Profiling::MemoryProfiler.new
        @memory_usage = Data::MemoryUsage.new
      end

      def analyze(&block)
        raise ArgumentError, "No block given" unless block_given?

        memory_before = @memory_usage.current
        benchmark_result = profile_benchmark(&block)
        memory_after = @memory_usage.current

        memory_stats = @memory_profiler.stats(memory_before, memory_after)
        cpu_stats = @cpu_profiler.stats

        generate_report(benchmark_result, memory_stats, cpu_stats)
      end

      private

      def profile_benchmark(&block)
        @benchmark_profiler.run do
          @memory_profiler.profile(&block)
          @cpu_profiler.profile
        end
      end

      def generate_report(benchmark_result, memory_stats, cpu_stats)
        report_generator = Reporting::ReportGenerator.new(
          @description,
          benchmark_result,
          memory_stats,
          cpu_stats,
        )
        report_generator.generate
      end
    end
  end
end
