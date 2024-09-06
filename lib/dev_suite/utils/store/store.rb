# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      require_relative "config"
      require_relative "driver"

      class Store
        def initialize
          @driver = Config.configuration.driver
        end

        def store(key, value)
          @driver.store(key, value)
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
      end

      class << self
        def store
          @store ||= Store.new
        end

        def reset!
          @store = nil
        end
      end
    end
  end
end
