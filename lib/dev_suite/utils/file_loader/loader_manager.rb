# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      class LoaderManager
        def load(path)
          loader = find_loader_for(path)
          loader.load(path)
        end

        private

        def find_loader_for(path)
          extension = extract_extension(path)
          loader = registry.find_loader(extension)
          raise LoaderNotFoundError, "No loader registered for #{extension}" unless loader

          loader
        end

        def extract_extension(path)
          ::File.extname(path).delete_prefix(".")
        end

        def registry
          Config.configuration.registry
        end
      end

      class LoaderNotFoundError < StandardError; end
    end
  end
end
