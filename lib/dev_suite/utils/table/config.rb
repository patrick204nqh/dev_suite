# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Config
        DEFAULTS = {
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

        def initialize(custom_settings = {})
          @settings = deep_merge(DEFAULTS, custom_settings)
        end

        def color_for(key)
          @settings[:colors][key] || DEFAULTS[:colors][:row]
        end

        def alignment_for(key)
          @settings[:alignments][key] || :left
        end

        private

        def deep_merge(original, override)
          original.merge(override) do |_key, oldval, newval|
            oldval.is_a?(Hash) ? deep_merge(oldval, newval) : newval
          end
        end
      end
    end
  end
end
