# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Config
      include Utils::ConfigTools::Configuration

      attr_reader :settings, :builder, :renderer

      def initialize(settings: {}, builder: :base, renderer: :simple)
        @settings = Settings.new(settings)
        @builder = Builder.create(builder)
        @renderer = Renderer.create(renderer)
        freeze # Make the instance of this class immutable as well
      end
    end
  end
end
