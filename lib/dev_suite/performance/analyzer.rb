# frozen_string_literal: true

module DevSuite
  module Performance
    class Analyzer
      def initialize(description: "Block")
        @description = description
        @profiler_manager = ProfilerManager.new
      end

      # Analyzes the performance of the given block
      # @param block [Proc] The block to be analyzed
      # @raise [ArgumentError] If no block is given
      def analyze(&block)
        raise ArgumentError, "No block given" unless block_given?

        outcome = @profiler_manager.run(&block)
        generate_report(@profiler_manager.results)
        outcome
      end

      private

      # Generates a performance report
      # @param benchmark_result [Benchmark::Tms] The benchmark result
      # @param memory_stats [Hash] The memory statistics
      def generate_report(results)
        Config.configuration.reportor.generate(
          description: @description,
          results: results,
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
