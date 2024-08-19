# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Config
        class Configuration < BaseConfiguration
          config_attr :strategy,
            default_value: :theme,
            type: :symbol,
            resolver: :resolve_strategy

          config_attr :palette,
            default_value: :default,
            type: :symbol,
            resolver: :resolve_palette

          private

          def resolve_strategy(value)
            Strategy.create(value)
          end

          def resolve_palette(value)
            Palette.create(value)
          end
        end
      end
    end
  end
end
