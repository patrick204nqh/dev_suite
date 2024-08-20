# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      require_relative "profiler/base"
      require_relative "profiler/execution_time"
      require_relative "profiler/memory"

      include Utils::Construct::ComponentManager

      register_component(:execution_time, ExecutionTime)
      register_component(:memory, Memory)
    end
  end
end
