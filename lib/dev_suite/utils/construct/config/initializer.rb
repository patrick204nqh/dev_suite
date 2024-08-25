# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Initializer
          extend self

          def define_constants(base)
            base.const_set(:BaseConfiguration, Configuration)

            unless base.const_defined?(:Configuration)
              base.const_set(:Configuration, Class.new(base::BaseConfiguration))
            end
          end
        end
      end
    end
  end
end
