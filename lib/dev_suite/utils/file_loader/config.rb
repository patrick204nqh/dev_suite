# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      class Config
        include ConfigTools::Configuration

        config_attr :loaders, default_value: [:text, :json, :yaml]

        def initialize(**options)
          super
          setup_registry
        end

        # Expose the registry as a read-only attribute
        attr_reader :registry

        private

        def validate_attr!(attr, value)
          case attr
          when :loaders
            validate_array!(attr, value)
          else
            super
          end
        end

        # Setup the registry based on the current loaders
        def setup_registry
          @registry = LoaderRegistry.new
          update_registry(loaders)
        end

        # Automatically update the registry whenever loaders are updated
        def resolve_attr(attr, value)
          case attr
          when :loaders
            update_registry(value)
            value
          else
            super
          end
        end

        # Update the registry with the provided loaders
        def update_registry(loaders)
          @registry ||= LoaderRegistry.new
          @registry.clear # Clear the existing registry
          Loader.registry_loaders(@registry, loaders)
        end
      end
    end
  end
end
