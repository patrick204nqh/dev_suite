# frozen_string_literal: true

module DevSuite
  module MethodTracer
    require_relative "tracer"
    require_relative "logger"
    require_relative "helpers"
    require_relative "config"

    class << self
      def trace(options = {}, &block)
        # Merge global configuration with options provided in the call
        settings = Config.configuration.settings.merge(options)

        # Use the merged settings to initialize the tracer
        Tracer.new(**settings).trace(&block)
      end
    end
  end
end
