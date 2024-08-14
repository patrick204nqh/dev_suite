# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Config
      include Utils::ConfigTools::Configuration

      # Define configuration attributes
      config_attr :settings, :renderer, :builder

      def initialize(settings: {}, builder: :base, renderer: :simple)
        # Set default values for settings, renderer and builder.
        self.settings = settings
        self.builder = builder
        self.renderer = renderer
      end

      private

      def validate_config_attr(attr, value)
        case attr
        when :renderer, :builder
          raise ArgumentError, "Invalid #{attr} value" unless value.is_a?(Symbol)
        when :settings
          raise ArgumentError, "Settings must be a hash" unless value.is_a?(Hash)
        else
          raise ArgumentError, "Invalid attribute"
        end
      end

      def resolve_config_attr(attr, value)
        case attr
        when :renderer
          Renderer.create(value)
        when :builder
          Builder.create(value)
        when :settings
          Settings.new(value)
        else
          raise ArgumentError, "Invalid attribute"
        end
      end
    end
  end
end
