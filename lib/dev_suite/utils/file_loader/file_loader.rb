# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      require "pathname"
      require "json"
      require "yaml"

      require_relative "loader"
      require_relative "loader_registry"
      require_relative "loader_manager"
      require_relative "config"

      class << self
        def load(path)
          loader = LoaderManager.new
          loader.load(path)
        end
      end
    end
  end
end
