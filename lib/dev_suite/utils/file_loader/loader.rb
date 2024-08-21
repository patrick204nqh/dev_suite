# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        require_relative "loader/base"
        require_relative "loader/text"
        require_relative "loader/json"
        require_relative "loader/yaml"

        class << self
          def registry_loaders(registry, loader_symbols)
            loader_classes = map_loaders(loader_symbols)
            loader_classes.each do |loader|
              registry.register(loader)
            end
            registry
          end

          private

          def map_loaders(loader_symbols)
            loader_symbols.map do |symbol|
              case symbol
              when :json
                Loader::Json
              when :text
                Loader::Text
              when :yaml
                Loader::Yaml
              else
                raise "Unknown loader: #{symbol}"
              end
            end
          end
        end
      end
    end
  end
end
