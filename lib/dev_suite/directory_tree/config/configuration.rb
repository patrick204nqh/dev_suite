# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Config
      class Configuration < BaseConfiguration
        # Define configuration attributes
        config_attr :settings, default_value: {}
        config_attr :builder, default_value: :base
        config_attr :renderer, default_value: :simple
        config_attr :visualizer, default_value: :tree

        private

        def validate_attr!(attr, value)
          case attr
          when :settings
            validate_hash!(attr, value)
          when :builder, :renderer, :visualizer
            validate_symbol!(attr, value)
          else
            raise ArgumentError, "Invalid attribute: #{attr}"
          end
        end

        def resolve_attr(attr, value)
          case attr
          when :settings
            Settings.new(value)
          when :builder
            Builder.create(value)
          when :renderer
            Renderer.create(value)
          when :visualizer
            Visualizer.create(value)
          else
            super # Return the value directly if no special resolution is needed
          end
        end
      end
    end
  end
end
