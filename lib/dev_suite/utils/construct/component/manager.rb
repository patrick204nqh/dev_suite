# frozen_string_literal: true

module DevSuite
  module Utils
    module Construct
      module Component
        module Manager
          class << self
            def included(base)
              base.extend(ClassMethods)
            end
          end

          module ClassMethods
            # Stores a mapping of component symbols to their respective classes
            def registered_components
              @registered_components ||= {}
            end

            # Build a single component
            def build_component(component_key, **options)
              component_class = registered_components[component_key]

              raise ArgumentError, "Component not found for key: #{component_key}" unless component_class

              component_class.new(**options)
            end

            # Build multiple components
            def build_components(component_keys)
              component_keys.map { |key| build_component(key) }
            end

            def build_component_from_instance(instance)
              component_class = registered_components.find do |klass, _|
                instance.is_a?(klass)
              end

              raise ArgumentError,
                "Component not found for instance: #{instance.class}" unless component_class

              component_class.last.new
            end

            private

            # Register a new component
            def register_component(component_class)
              raise ArgumentError,
                "#{component_class} must define a component_key" unless component_class.respond_to?(:component_key)

              registered_components[component_class.component_key] = component_class
            end

            # Load a dependency and execute a block if successful
            def load_dependency(*dependencies, on_failure:, &block)
              DependencyLoader.safe_load_dependencies(*dependencies, on_failure: on_failure, &block)
            end
          end
        end
      end
    end
  end
end
