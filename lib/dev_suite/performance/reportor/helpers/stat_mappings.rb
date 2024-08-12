# frozen_string_literal: true

module DevSuite
  module Performance
    module Reportor
      module Helpers
        module StatMappings
          PROFILER_STAT_TITLES = {
            execution_time: {
              real: "Total Time (s)",
              utime: "User CPU Time (s)",
              stime: "System CPU Time (s)",
              total: "User + System CPU Time (s)",
            },
            memory: {
              before: "Memory Before (MB)",
              after: "Memory After (MB)",
              used: "Memory Used (MB)",
              max: "Max Memory Used (MB)",
              min: "Min Memory Used (MB)",
              avg: "Avg Memory Used (MB)",
            },
          }.freeze

          class << self
            def title_for(profiler_name, stat_name)
              PROFILER_STAT_TITLES.dig(profiler_name, stat_name) || format_default_title(stat_name)
            end

            private

            def format_default_title(metric)
              metric.to_s.split("_").map(&:capitalize).join(" ")
            end
          end
        end
      end
    end
  end
end
