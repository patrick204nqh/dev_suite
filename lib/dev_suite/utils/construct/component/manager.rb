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

            # Check if a component is registered
            def component_registered?(component_key)
              unless registered_components.key?(component_key)
                Utils::Logger.log("Component not found for key: #{component_key}", level: :warn, emoji: :warning)
                return false
              end
              true
            end

            # Build a single component
            def build_component(component_key, **options, &block)
              component_class = registered_components[component_key]

              raise ArgumentError, "Component not found for key: #{component_key}" unless component_class

              # Check if options are empty to avoid passing unnecessary keyword arguments in Ruby 2.6
              if options.empty?
                component_class.new(&block)
              else
                component_class.new(**options, &block)
              end
            end

            # Build multiple components by filtering registered ones
            def build_components(component_keys)
              component_keys.select { |key| component_registered?(key) }
                .map { |key| build_component(key) }
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
            def load_dependency(dependencies = [], on_failure: -> {}, &block)
              DependencyLoader.safe_load_dependencies(dependencies, on_failure: on_failure, &block)
            end
          end
        end
      end
    end
  end
end
