# frozen_string_literal: true

require "get_process_mem"

module DevSuite
  module Performance
    module Data
      class MemoryUsage
        def current
          GetProcessMem.new.mb
        end
      end
    end
  end
end
