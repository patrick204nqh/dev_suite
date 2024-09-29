# frozen_string_literal: true

module DevSuite
  module Utils
    module Logger
      require_relative "formatter"
      require_relative "emoji"
      require_relative "errors"

      class Base
        LOG_LEVELS = [:none, :info, :warn, :error, :debug].freeze

        attr_accessor :log_level

        def initialize(log_level: :none)
          validate_log_level(log_level)
          @log_level = log_level
        end

        # Logs a message with optional emoji, prefix, and color.
        def log(message, level: :none, emoji: nil, prefix: nil, color: nil)
          validate_log_level(level)
          return if skip_logging?(level)

          formatted_message = Formatter.format(message, level, emoji, prefix, color)
          output_log(formatted_message)
        end

        private

        def validate_log_level(level)
          return if LOG_LEVELS.include?(level)

          raise InvalidLogLevelError, "Invalid log level: #{level}. Valid levels are: #{LOG_LEVELS.join(", ")}."
        end

        def skip_logging?(level)
          LOG_LEVELS.index(level) < LOG_LEVELS.index(@log_level)
        end

        def output_log(formatted_message)
          puts formatted_message if formatted_message
        end
      end
    end
  end
end
