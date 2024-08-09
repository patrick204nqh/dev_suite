# frozen_string_literal: true

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
          # TODO: need to review and implement this method
          10
        end
      end
    end
  end
end
