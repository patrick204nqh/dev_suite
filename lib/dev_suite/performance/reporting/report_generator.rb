# frozen_string_literal: true

require_relative "../../utils"

module DevSuite
  module Performance
    module Reporting
      class ReportGenerator
        def initialize(description, benchmark_result, memory_stats)
          @description = description
          @benchmark_result = benchmark_result
          @memory_stats = memory_stats
        end

        # Generates the performance report
        def generate
          table = create_table
          populate_table(table)
          render_table(table)
        end

        private

        #
        # Creates a new table with the specified configuration
        #
        def create_table
          config = Utils::Table::Config.new
          Utils::Table::Table.new(config).tap do |table|
            table.title = "Performance Analysis"
            table.add_columns("Metric", "Value")
          end
        end

        #
        # Populates the table with benchmark and memory statistics
        #
        def populate_table(table)
          table.add_row(["Description", @description])
          table.add_row(["Total Time (s)", format("%.6f", @benchmark_result.real)])
          table.add_row(["User CPU Time (s)", format("%.6f", @benchmark_result.utime)])
          table.add_row(["System CPU Time (s)", format("%.6f", @benchmark_result.stime)])
          table.add_row(["User + System CPU Time (s)", format("%.6f", @benchmark_result.total)])
          table.add_row(["Memory Before (MB)", format("%.2f", @memory_stats[:before])])
          table.add_row(["Memory After (MB)", format("%.2f", @memory_stats[:after])])
          table.add_row(["Memory Used (MB)", format("%.2f", @memory_stats[:used])])
          table.add_row(["Max Memory Used (MB)", format("%.2f", @memory_stats[:max])])
          table.add_row(["Min Memory Used (MB)", format("%.2f", @memory_stats[:min])])
          table.add_row(["Avg Memory Used (MB)", format("%.2f", @memory_stats[:avg])])
        end

        #
        # Renders the table using the specified renderer
        #
        def render_table(table)
          renderer = Utils::Table::Renderer::Simple.new
          puts table.render(renderer: renderer)
        end
      end
    end
  end
end
