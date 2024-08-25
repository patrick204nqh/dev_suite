# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        require_relative "attribute"
        require_relative "hook"
        require_relative "settings"
        require_relative "dependency_handler"
        require_relative "base"
        require_relative "manager"
        require_relative "initializer"

        class << self
          def included(base)
            base.extend(Manager)
            Initializer.define_constants(base)
          end
        end
      end
    end
  end
end
