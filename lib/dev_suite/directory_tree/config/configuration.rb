# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Config
      class Configuration < BaseConfiguration
        set_default_settings(
          skip_hidden: false,
          skip_types: [],
          max_depth: nil,
          max_size: 100 * 1024 * 1024, # 100 MB
          includes: [],
          excludes: [],
        )

        # Define configuration attributes
        config_attr :builder, default_value: :base, type: :symbol, resolver: ->(value) { Builder.create(value) }
        config_attr :renderer, default_value: :simple, type: :symbol, resolver: ->(value) { Renderer.create(value) }
        config_attr :visualizer, default_value: :tree, type: :symbol, resolver: ->(value) { Visualizer.create(value) }
      end
    end
  end
end
