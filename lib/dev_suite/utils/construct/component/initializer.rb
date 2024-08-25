# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Initializer
          extend self

          def define_constants(base)
            base.const_set(:BaseComponent, Base)
          end
        end
      end
    end
  end
end
