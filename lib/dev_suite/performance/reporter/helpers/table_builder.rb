# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      module Helpers
        module TableBuilder
          class << self
            def build_table(description, results)
              table = initialize_table
              add_description(table, description)
              add_profiler_data(table, results)
              table
            end

            private

            def initialize_table
              Utils::Table::Table.new.tap do |table|
                table.title = "Performance Analysis"
                table.add_columns("Metric", "Value")
              end
            end

            def add_description(table, description)
              table.add_row(["Description", description])
            end

            def add_profiler_data(table, results)
              results.each do |profiler_name, stats|
                # table.add_row(["#{profiler_name.to_s.capitalize} Profiler", ""])
                stats.each do |metric, value|
                  title = StatMappings.title_for(profiler_name, metric)
                  table.add_row([title, format_value(value)])
                end
              end
            end

            def format_value(value)
              format("%.6f", value)
            end
          end
        end
      end
    end
  end
end
