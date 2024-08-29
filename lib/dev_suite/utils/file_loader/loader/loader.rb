# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        include Construct::Component::Manager

        require_relative "base"

        class << self
          # Registers the specified loaders with the given registry.
          #
          # @param registry [Object] the registry to register loaders with
          # @param loader_symbols [Array<Symbol>] the symbols representing the loaders to register
          # @return [Object] the updated registry
          def registry_loaders(registry, loader_symbols)
            loader_classes = registered_components.values_at(*loader_symbols)
            loader_classes.each do |loader|
              registry.register(loader)
            end
            registry
          end

          def handle_missing_dependencies(missing_dependencies)
            Config.configuration.remove_failed_dependency(:loaders, :json, *missing_dependencies)
          end
        end

        require_relative "text"
        register_component(Text)

        load_dependency("json", on_failure: method(:handle_missing_dependencies)) do
          require_relative "json"
          register_component(Json)
        end

        load_dependency("yaml", on_failure: method(:handle_missing_dependencies)) do
          require_relative "yaml"
          register_component(Yaml)
        end
      end
    end
  end
end
