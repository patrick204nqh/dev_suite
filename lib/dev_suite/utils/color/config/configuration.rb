# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Config
        class Configuration < BaseConfiguration
          config_attr :strategy, default_value: :theme
          config_attr :palette, default_value: :default

          private

          def validate_attr!(attr_name, value)
            case attr_name
            when :strategy, :palette
              validate_symbol!(attr_name, value)
            else
              super
            end
          end

          def resolve_attr(attr_name, value)
            case attr_name
            when :strategy
              Strategy.create(value)
            when :palette
              Palette.create(value)
            else
              super
            end
          end
        end
      end
    end
  end
end
