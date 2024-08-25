# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Config
        module Initializer
          extend self

          def define_constants(base)
            structure_module = ensure_structure_module(base)
            define_structure_configuration(structure_module)
            define_base_configuration(base, structure_module)
          end

          private

          def ensure_structure_module(base)
            base.const_defined?(:Structure) ? base.const_get(:Structure) : base.const_set(:Structure, Module.new)
          end

          def define_structure_configuration(structure_module)
            structure_module.const_set(:Configuration, Base) unless structure_module.const_defined?(:Configuration)
          end

          def define_base_configuration(base, structure_module)
            unless base.const_defined?(:Configuration)
              base.const_set(:Configuration, Class.new(structure_module::Configuration))
            end
          end
        end
      end
    end
  end
end
