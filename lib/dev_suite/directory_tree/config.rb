# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    class Config
      include Utils::Configurable

      attr_reader :renderer

      def initialize(renderer: :simple)
        @renderer = Renderer.create(renderer)
        freeze # Make the instance of this class immutable as well
      end
    end
  end
end
