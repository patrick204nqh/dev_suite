# frozen_string_literal: true

module DevSuite
  module Performance
    class ProfilerManager
      attr_reader :results

      # TODO: building as function in Construct::Component
      def initialize
        @results = {}
      end

      # Runs the configured profilers and returns the final result
      def run(&block)
        outcome = block.call
        run_profilers(outcome)
      end

      private

      # Runs each profiler and updates the results
      # @param result [Object] The initial result from the block
      # @return [Object] The final result after running all profilers
      def run_profilers(outcome)
        Config.configuration.profilers.each do |profiler|
          outcome = run_profiler(profiler, outcome)
        end
        outcome
      end

      # Runs a single profiler and updates the results
      # @param profiler [Profiler] The profiler to run
      # @param result [Object] The current result
      # @return [Object] The result after running the profiler
      def run_profiler(profiler, outcome)
        outcome = profiler.run { outcome }
        update_results(profiler)
        outcome
      end

      # Updates the results hash with the stats from the profiler
      # @param profiler [Profiler] The profiler whose stats to update
      def update_results(profiler)
        key = to_snake_case(profiler.class.name.split("::").last)
        @results[key] = profiler.stats
      end

      # Convert a class name to a snake_case symbol
      # @param class_name [String] The class name to convert
      # @return [Symbol] The snake_case symbol
      def to_snake_case(class_name)
        class_name.gsub(/([a-z])([A-Z])/, '\1_\2').downcase.to_sym
      end
    end
  end
end
