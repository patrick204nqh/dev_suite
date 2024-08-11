# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Config
        include ConfigTools::Configuration

        DEFAULT_SETTING = {
          colors: {
            title: :cyan,
            column: :yellow,
            row: :default,
            border: :blue,
          },
          alignments: {
            column: :left,
            row: :left,
          },
        }.freeze

        attr_reader :settings, :renderer

        def initialize(settings: {}, renderer: :simple)
          @settings = Settings.new(settings)
          @renderer = Renderer.create(renderer, settings: @settings)
          freeze
        end
      end
    end
  end
end
