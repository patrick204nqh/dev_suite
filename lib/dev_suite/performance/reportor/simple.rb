# frozen_string_literal: true

module DevSuite
  module Performance
    module Reportor
      class Simple < Base
        #
        # Generates the performance report
        #
        def generate(description:, benchmark_result:, memory_stats:)
          table = create_table
          populate_table(
            table,
            description: description,
            benchmark_result: benchmark_result,
            memory_stats: memory_stats,
          )
          render_table(table)
        end

        private

        #
        # Creates a new table with the specified configuration
        #
        def create_table
          table = Utils::Table::Table.new
          table.tap do |t|
            t.title = "Performance Analysis"
            t.add_columns("Metric", "Value")
          end
        end

        #
        # Populates the table with benchmark and memory statistics
        #
        def populate_table(table, description: "", benchmark_result: nil, memory_stats: {})
          validate_benchmark_result(benchmark_result)
          validate_memory_stats(memory_stats)

          table.add_row(["Description", description])
          table.add_row(["Total Time (s)", format("%.6f", benchmark_result.real)])
          table.add_row(["User CPU Time (s)", format("%.6f", benchmark_result.utime)])
          table.add_row(["System CPU Time (s)", format("%.6f", benchmark_result.stime)])
          table.add_row(["User + System CPU Time (s)", format("%.6f", benchmark_result.total)])
          table.add_row(["Memory Before (MB)", format("%.2f", memory_stats[:before])])
          table.add_row(["Memory After (MB)", format("%.2f", memory_stats[:after])])
          table.add_row(["Memory Used (MB)", format("%.2f", memory_stats[:used])])
          table.add_row(["Max Memory Used (MB)", format("%.2f", memory_stats[:max])])
          table.add_row(["Min Memory Used (MB)", format("%.2f", memory_stats[:min])])
          table.add_row(["Avg Memory Used (MB)", format("%.2f", memory_stats[:avg])])
        end

        #
        # Renders the table using the specified renderer
        #
        def render_table(table)
          puts table.render
        end

        #
        # Validates the benchmark_result object
        #
        def validate_benchmark_result(benchmark_result)
          required_methods = [:real, :utime, :stime, :total]
          missing_methods = required_methods.reject { |method| benchmark_result.respond_to?(method) }
          unless missing_methods.empty?
            raise ArgumentError, "benchmark_result is missing required methods: #{missing_methods.join(", ")}"
          end
        end

        #
        # Validates the memory_stats hash
        #
        def validate_memory_stats(memory_stats)
          required_keys = [:before, :after, :used, :max, :min, :avg]
          missing_keys = required_keys.reject { |key| memory_stats.key?(key) }
          unless missing_keys.empty?
            raise ArgumentError, "memory_stats is missing required keys: #{missing_keys.join(", ")}"
          end
        end
      end
    end
  end
end
