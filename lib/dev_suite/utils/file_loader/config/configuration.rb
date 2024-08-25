# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Config
        class Configuration < Structure::Configuration
          config_attr :loaders, default_value: [:text, :json, :yaml], type: :array

          register_hook :after_initialize do
            setup_registry
          end

          # Expose the registry as a read-only attribute
          attr_reader :registry

          # Setup the registry based on the current loaders
          def setup_registry
            @registry = LoaderRegistry.new
            update_registry(loaders)
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
end
