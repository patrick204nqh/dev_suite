# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Setting
        DEFAULT = {
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

        attr_reader :setting

        def initialize(setting = {})
          @setting = deep_merge(DEFAULT, setting)
          freeze
        end

        class << self
          def create(setting = {})
            new(setting)
          end
        end

        def color_for(key)
          @setting[:colors][key] || DEFAULT[:colors][:row]
        end

        def alignment_for(key)
          @setting[:alignments][key] || :left
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
