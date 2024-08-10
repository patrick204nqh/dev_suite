# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      class Colorizer
        attr_reader :config

        def initialize(config = Config.configuration)
          @config = config
        end

        def colorize(text, **kargs)
          puts @config.strategy.colorize(text, **kargs)
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
