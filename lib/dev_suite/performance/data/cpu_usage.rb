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
          begin
            # Get the current process information
            proc_info = Sys::ProcTable.ps(pid: Process.pid)

            # Calculate total CPU time using threads_user and threads_system
            total_time = proc_info.threads_user + proc_info.threads_system
            cpu_usage = (total_time.to_f / (total_time + 1)) * 100

            cpu_usage
          rescue Sys::ProcTable::Error => e
            puts "Error: Unable to get CPU usage: #{e.message}"
            0
          end
        end
      end
    end
  end
end
