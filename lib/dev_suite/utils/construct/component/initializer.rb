# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Initializer
          extend self

          def define_constants(base)
            structure_module = ensure_structure_module(base)
            define_structure_component(structure_module)
          end

          private

          def ensure_structure_module(base)
            base.const_defined?(:Structure) ? base.const_get(:Structure) : base.const_set(:Structure, Module.new)
          end

          def define_structure_component(structure_module)
            structure_module.const_set(:Component, Base) unless structure_module.const_defined?(:Component)
          end
        end
      end
    end
  end
end
