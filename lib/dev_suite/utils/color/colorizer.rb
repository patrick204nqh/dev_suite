# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      class << self
        def colorize(text, **kargs)
          Colorizer.new(Config.configuration).colorize(text, **kargs)
        end
      end

      class Colorizer
        attr_reader :config

        def initialize(config = Config.configuration)
          @config = config
        end

        def colorize(text, **kargs)
          puts @config.strategy.colorize(text, **kargs)
        end
      end
    end
  end
end
