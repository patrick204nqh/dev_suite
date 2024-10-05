# frozen_string_literal: true

module DevSuite
  module Utils
    module Logger
      require_relative "base"

      class << self
        # Provides access to the global logger instance
        #
        # @return [Base] the global logger instance
        def logger
          @logger ||= Base.new
        end

        # Logs a message using the global logger instance
        #
        # @param message [String] The message to log.
        # @param level [Symbol] The log level (:none, :info, :warn, :error, :debug).
        # @param emoji [String, Symbol, nil] Optional emoji to prepend to the message.
        # @param prefix [String, nil] Custom prefix for the message.
        # @param color [Symbol, nil] Custom color for the message.
        def log(message, level: :none, emoji: nil, prefix: nil, color: nil)
          logger.log(message, level: level, emoji: emoji, prefix: prefix, color: color)
        end
      end
    end
  end
end
