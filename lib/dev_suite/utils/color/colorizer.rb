# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      class Colorizer
        def colorize(text, **kargs)
          Config.configuration.strategy.colorize(text, **kargs)
        end
      end

      class << self
        def colorize(text, **kargs)
          raise ArgumentError, "Text to colorize must be a string" unless text.is_a?(String)

          colorizer = Colorizer.new
          colorizer.colorize(text, **kargs)
        end
      end
    end
  end
end
