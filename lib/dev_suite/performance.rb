# frozen_string_literal: true

module DevSuite
  module Performance
    require "benchmark"
    require "get_process_mem"

    require_relative "performance/data"
    require_relative "performance/profiler"
    require_relative "performance/reportor"
    require_relative "performance/analyzer"
    require_relative "performance/config"
  end
end
