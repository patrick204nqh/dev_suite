# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Initializer
          class << self
            def define_config_constants(base)
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
end
