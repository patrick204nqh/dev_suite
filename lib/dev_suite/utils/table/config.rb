# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Config
        include Configurable

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

        attr_reader :setting, :renderer

        def initialize(setting: {}, renderer: :simple)
          @setting = Setting.create(setting)
          @renderer = Renderer.create(renderer, setting: @setting)
          freeze
        end
      end
    end
  end
end
