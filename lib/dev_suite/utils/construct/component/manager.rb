# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Manager
          # Stores a mapping of component symbols to their respective classes
          def registered_components
            @registered_components ||= {}
          end

          # Register a new component
          def register_component(key, component_class)
            registered_components[key] = component_class
          end

          # Build a single component
          def build(key, **options)
            component_class = registered_components[key]
            raise ArgumentError, "Component not found: #{key}" unless component_class

            component_class.new(**options)
          end

          # Build multiple components
          def build_all(keys, **options)
            keys.map { |key| build(key, **options) }
          end

          def find_component(instance)
            component_class = registered_components.find do |klass, _|
              instance.is_a?(klass)
            end

            raise ArgumentError, "Component not found for instance: #{instance.class}" unless component_class

            component_class.last.new
          end
        end
      end
    end
  end
end
