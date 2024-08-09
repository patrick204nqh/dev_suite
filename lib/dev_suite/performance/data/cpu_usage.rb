# frozen_string_literal: true

require "sys/proctable"
require "rbconfig"

module DevSuite
  module Performance
    module Data
      class CpuUsage
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
          proc_info = Sys::ProcTable.ps(pid: Process.pid)
          total_time = total_cpu_time(proc_info)
          cpu_usage = (total_time.to_f / (total_time + 1)) * 100
          cpu_usage
        rescue StandardError => e
          puts "Error: Unable to get CPU usage: #{e.message}"
          0
        end

        def total_cpu_time(proc_info)
          platform = RbConfig::CONFIG["host_os"]
          case platform
          when /darwin/
            proc_info.total_user + proc_info.total_system
          when /linux/
            proc_info.utime + proc_info.stime
          else
            raise "Unsupported platform: #{platform}"
          end
        end
      end
    end
  end
end
