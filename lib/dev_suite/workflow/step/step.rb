# frozen_string_literal: true

module DevSuite
  module Workflow
    module Step
      include Utils::Construct::Component::Manager

      require_relative "base"
      require_relative "composite"
      require_relative "conditional"
      require_relative "loop"
      require_relative "parallel"

      register_component Base
      register_component Composite
      register_component Conditional
      register_component Loop
      register_component Parallel
    end
  end
end
