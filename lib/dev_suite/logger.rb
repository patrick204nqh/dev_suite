# frozen_string_literal: true

module DevSuite
  module Logger
    LOG_DETAILS = {
      info: { prefix: "[INFO]", color: :green },
      warn: { prefix: "[WARNING]", color: :yellow },
      error: { prefix: "[ERROR]", color: :red },
      debug: { prefix: "[DEBUG]", color: :blue },
    }.freeze

    class << self
      # Logs a message with an optional emoji and specified log level.
      #
      # @param message [String] The message to log.
      # @param level [Symbol] The log level (:info, :warn, :error, :debug).
      # @param emoji [String, Symbol] Optional emoji to prepend to the message.
      def log(message, level: :info, emoji: nil)
        emoji_icon = resolve_emoji(emoji)
        formatted_message = format_message("#{emoji_icon} #{message}", level)
        output_log(formatted_message)
      end

      private

      # Resolves the emoji, either from a symbol or directly as a string.
      #
      # @param emoji [String, Symbol, nil] The emoji or its symbol key.
      # @return [String] The resolved emoji or an empty string if none is provided.
      def resolve_emoji(emoji)
        return "" unless emoji

        emoji.is_a?(Symbol) ? Emoji.get(emoji) : emoji
      end

      # Formats the log message with the appropriate prefix and color.
      #
      # @param message [String] The message to format.
      # @param level [Symbol] The log level (:info, :warn, :error, :debug).
      # @return [String] The formatted log message.
      def format_message(message, level)
        details = LOG_DETAILS[level]
        raise ArgumentError, "Invalid log level: #{level}" unless details

        Utils::Color.colorize("#{details[:prefix]} #{message}", color: details[:color])
      end

      # Outputs the formatted log message to the console.
      #
      # @param formatted_message [String] The message to output.
      def output_log(formatted_message)
        puts formatted_message if formatted_message
      end
    end
  end
end
