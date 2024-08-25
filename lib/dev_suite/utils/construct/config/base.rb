# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        class Base
          # Foundation for all configurations
          include Attribute
          include Hook

          # Include the settings manager and dependency handler
          include Settings::Manager
          include DependencyHandler

          def initialize
            run_hooks(:before_initialize)
            initialize_config_attrs
            run_hooks(:after_initialize)
          end
        end
      end
    end
  end
end
