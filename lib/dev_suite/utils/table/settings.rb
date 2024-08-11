# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      class Settings
        include ConfigTools::Settings

        def default_settings
          {
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
          }
        end

        def color_for(key)
          get(:colors, key)
        end

        def alignment_for(key)
          get(:alignments, key)
        end
      end
    end
  end
end
