# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      include Utils::Construct::Component

      require_relative "base"
      require_relative "execution_time"
      require_relative "memory"

      register_component(:execution_time, ExecutionTime)
      register_component(:memory, Memory)
    end
  end
end
