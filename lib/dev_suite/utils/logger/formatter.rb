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
          def format(message, level, emoji, custom_prefix, custom_color)
            details = LOG_DETAILS[level]
            prefix = custom_prefix || details[:prefix]
            color = custom_color || details[:color]
            emoji_icon = Emoji.resolve(emoji)

            Utils::Color.colorize("#{prefix} #{emoji_icon} #{message}".strip, color: color)
          end
        end
      end
    end
  end
end
