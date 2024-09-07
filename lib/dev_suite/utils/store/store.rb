# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      require_relative "config"
      require_relative "driver"

      class Store
        def initialize(driver: nil)
          @driver = initialize_driver(driver)
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

        def config_driver
          Config.configuration.driver
        end

        def initialize_driver(driver)
          return config_driver if driver.nil?

          Driver.build_component(driver)
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
