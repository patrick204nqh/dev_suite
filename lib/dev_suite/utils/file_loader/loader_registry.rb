# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      class LoaderRegistry
        def initialize
          @registry = {}
        end

        def register(loader_class)
          loader = loader_class.new
          loader_class.extensions.each do |ext|
            @registry[ext] = loader
          end
        end

        def clear
          @registry.clear
        end

        def find_loader(extension)
          @registry[extension]
        end

        def registered_extensions
          @registry.keys
        end

        def registered_loaders
          @registry.values.uniq
        end
      end
    end
  end
end
