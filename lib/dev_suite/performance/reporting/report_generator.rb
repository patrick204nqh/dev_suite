require_relative '../../utils/table/table_formatter'

module DevSuite
  module Performance
    module Reporting
      class ReportGenerator
        def initialize(description, benchmark_result, memory_stats, cpu_stats)
          @description = description
          @benchmark_result = benchmark_result
          @memory_stats = memory_stats
          @cpu_stats = cpu_stats
        end

        def generate
          formatter = Utils::Table::TableFormatter.new
          formatter.set_title('Performance Analysis', color: :cyan)
          formatter.set_headings(['Metric', 'Value'], color: :yellow)
          formatter.add_row(['Description', @description])
          formatter.add_row(['Total Time (s)', format('%.6f', @benchmark_result.real)])
          formatter.add_row(['User CPU Time (s)', format('%.6f', @benchmark_result.utime)])
          formatter.add_row(['System CPU Time (s)', format('%.6f', @benchmark_result.stime)])
          formatter.add_row(['User + System CPU Time (s)', format('%.6f', @benchmark_result.total)])
          formatter.add_row(['Memory Before (MB)', format('%.2f', @memory_stats[:before])])
          formatter.add_row(['Memory After (MB)', format('%.2f', @memory_stats[:after])])
          formatter.add_row(['Memory Used (MB)', format('%.2f', @memory_stats[:used])])
          formatter.add_row(['Max Memory Used (MB)', format('%.2f', @memory_stats[:max])])
          formatter.add_row(['Min Memory Used (MB)', format('%.2f', @memory_stats[:min])])
          formatter.add_row(['Avg Memory Used (MB)', format('%.2f', @memory_stats[:avg])])
          formatter.add_row(['Avg CPU Usage (%)', format('%.2f', @cpu_stats[:avg])])
          formatter.add_row(['Peak CPU Usage (%)', format('%.2f', @cpu_stats[:peak])])

          puts formatter.to_table
        end
      end
    end
  end
end
