# frozen_string_literal: true

module DevSuite
  module Performance
    module Profiler
      include Utils::Construct::Component

      require_relative "base"
      require_relative "execution_time"
      require_relative "memory"

      register_component(ExecutionTime)
      register_component(Memory)
    end
  end
end
