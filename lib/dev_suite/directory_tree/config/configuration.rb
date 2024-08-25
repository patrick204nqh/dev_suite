# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Config
      class Configuration < Structure::Configuration
        set_default_settings(
          skip_hidden: false,
          skip_types: [],
          max_depth: nil,
          max_size: 100 * 1024 * 1024, # 100 MB
        )

        config_attr :builder, default_value: :base, type: :symbol, resolver: :resolve_builder
        config_attr :renderer, default_value: :simple, type: :symbol, resolver: :resolve_renderer
        config_attr :visualizer, default_value: :tree, type: :symbol, resolver: :resolve_visualizer

        private

        def resolve_builder(value)
          Builder.build_component(value)
        end

        def resolve_renderer(value)
          Renderer.build_component(value)
        end

        def resolve_visualizer(value)
          Visualizer.build_component(value)
        end
      end
    end
  end
end
