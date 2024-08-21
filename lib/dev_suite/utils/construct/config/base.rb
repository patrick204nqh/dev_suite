# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        class Base
          include Attribute::Manager
          include Hook::Manager

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
