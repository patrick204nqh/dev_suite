# frozen_string_literal: true

module DevSuite
  module Utils
    module Logger
      module Formatter
        LOG_DETAILS = {
          none: { prefix: "", color: :white },
          info: { prefix: "[INFO]", color: :green },
          warn: { prefix: "[WARNING]", color: :yellow },
          error: { prefix: "[ERROR]", color: :red },
          debug: { prefix: "[DEBUG]", color: :blue },
        }.freeze

        class << self
          def format(message, options = {})
            return "" if message.nil? || message.strip.empty?

            details = fetch_log_details(options[:level])
            prefix = options[:prefix] || details[:prefix]
            color = options[:color] || details[:color]
            emoji_icon = Emoji.resolve(options[:emoji])

            formatted_message = build_message(prefix, emoji_icon, message)
            Utils::Color.colorize(formatted_message, color: color)
          end

          private

          def fetch_log_details(level)
            LOG_DETAILS[level || :none]
          end

          def build_message(prefix, emoji_icon, message)
            "#{prefix} #{emoji_icon} #{message}".strip
          end
        end
      end
    end
  end
end
