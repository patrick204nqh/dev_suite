# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Config
        class Configuration < BaseConfiguration
          config_attr :settings, default_value: {}
          config_attr :renderer, default_value: :simple

          private

          def validate_attr!(attr, value)
            case attr
            when :settings
              validate_hash!(attr, value)
            when :renderer
              validate_symbol!(attr, value)
            else
              raise ArgumentError, "Invalid attribute: #{attr}"
            end
          end

          def resolve_attr(attr, value)
            case attr
            when :settings
              Settings.new(value)
            when :renderer
              Renderer.create(value)
            else
              super
            end
          end
        end
      end
    end
  end
end
