# frozen_string_literal: true

require "sys/proctable"

module DevSuite
  module Performance
    module Data
      class CPUUsage
        def initialize
          @cpu_points = []
        end

        def record
          @cpu_points << current
        end

        def average
          return 0 if @cpu_points.empty?

          @cpu_points.sum / @cpu_points.size
        end

        def peak
          @cpu_points.max || 0
        end

        private

        def current
          # Get the current process information
          proc_info = Sys::ProcTable.ps(pid: Process.pid)

          # Calculate CPU usage percentage
          total_time = proc_info.total_user + proc_info.total_system
          cpu_usage = (total_time.to_f / (proc_info.total_user + proc_info.total_system + 1)) * 100

          cpu_usage
        end
      end
    end
  end
end
