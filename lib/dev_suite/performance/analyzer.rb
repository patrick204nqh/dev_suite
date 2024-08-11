# frozen_string_literal: true

module DevSuite
  module Performance
    class Analyzer
      def initialize(description: "Block")
        @description = description

        @benchmark_profiler = Profiler::Benchmark.new
        @memory_profiler = Profiler::Memory.new
        @memory_usage = Data::MemoryUsage.new
      end

      # Analyzes the performance of the given block
      # @param block [Proc] The block to be analyzed
      # @raise [ArgumentError] If no block is given
      def analyze(&block)
        raise ArgumentError, "No block given" unless block_given?

        memory_before = @memory_usage.current
        benchmark_result = profile_benchmark(&block)
        memory_after = @memory_usage.current

        memory_stats = @memory_profiler.stats(memory_before, memory_after)

        generate_report(benchmark_result, memory_stats)
      end

      private

      # Profiles the benchmark of the given block
      # @param block [Proc] The block to be benchmarked
      # @return [Benchmark::Tms] The benchmark result
      def profile_benchmark(&block)
        @benchmark_profiler.run do
          @memory_profiler.profile(&block)
        end
      end

      # Generates a performance report
      # @param benchmark_result [Benchmark::Tms] The benchmark result
      # @param memory_stats [Hash] The memory statistics
      def generate_report(benchmark_result, memory_stats)
        Config.configuration.reportor.generate(
          description: @description,
          benchmark_result: benchmark_result,
          memory_stats: memory_stats,
        )
      end
    end

    class << self
      def analyze(description: "Block", &block)
        analyzer = Analyzer.new(description: description)
        analyzer.analyze(&block)
      end
    end
  end
end
