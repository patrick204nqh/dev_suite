# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Config
        class Configuration < BaseConfiguration
          config_attr :strategy,
            default_value: :theme,
            type: :symbol,
            resolver: ->(value) { Strategy.create(value) }

          config_attr :palette,
            default_value: :default,
            type: :symbol,
            resolver: ->(value) { Palette.create(value) }
        end
      end
    end
  end
end
