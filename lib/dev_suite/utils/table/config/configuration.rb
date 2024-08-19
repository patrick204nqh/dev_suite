# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Config
        class Configuration < BaseConfiguration
          set_default_settings(
            colors: {
              title: :cyan,
              column: :yellow,
              row: :default,
              border: :blue,
            },
            # alignments: {
            #   column: :left,
            #   row: :left,
            # },
          )

          config_attr :renderer, default_value: :simple, type: :symbol, resolver: :resolve_renderer

          private

          def resolve_renderer(value)
            Renderer.create(value)
          end
        end
      end
    end
  end
end
