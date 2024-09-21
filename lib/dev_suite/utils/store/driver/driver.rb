# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Driver
        include Construct::Component::Manager

        require_relative "base"
        require_relative "file"
        require_relative "memory"

        register_component(File)
        register_component(Memory)
      end
    end
  end
end
