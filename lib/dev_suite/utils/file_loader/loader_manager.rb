module DevSuite
  module Utils
    module FileLoader
      class LoaderManager
        def load(path)
          extension = ::File.extname(path)
          loader = registry.find_loader(extension)
          raise ArgumentError, "No loader registered for #{extension}" unless loader

          loader.load(path)
        end

        private

        def registry
          Config.configuration.registry
        end
      end
    end
  end
end
