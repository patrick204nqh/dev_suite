# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      require_relative "config"
      require_relative "driver"

      class Store
        def initialize(**options)
          @driver = initialize_driver(**options)
        end

        def set(key, value)
          @driver.set(key, value)
        end

        def fetch(key)
          @driver.fetch(key)
        end

        def delete(key)
          @driver.delete(key)
        end

        def import(source)
          @driver.import(source)
        end

        def export(destination)
          @driver.export(destination)
        end

        def clear
          @driver.clear
        end

        private

        def initialize_driver(**options)
          return Config.configuration.driver unless options.key?(:driver)

          build_driver(options)
        end

        def build_driver(options)
          driver_type = options.fetch(:driver)
          driver_options = options.reject { |key, _| key == :driver }
          Driver.build_component(driver_type, **driver_options)
        end
      end

      class << self
        # Retrieve the singleton store instance
        def instance
          @store ||= Store.new
        end

        # Reset the singleton store instance
        def reset!
          @store = nil
        end

        # Create a new store instance (isolated from the singleton)
        def create(**options)
          Store.new(**options)
        end
      end
    end
  end
end
