# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Config
        class Configuration < Utils::Construct::Config::Base
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
            Strategy.build_component(value)
          end

          def resolve_palette(value)
            Palette.build_component(value)
          end
        end
      end
    end
  end
end
