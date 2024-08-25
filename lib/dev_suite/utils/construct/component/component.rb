# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
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
