# frozen_string_literal: true

module DevSuite
  module Logger
    LOG_DETAILS = {
      info: { prefix: "[INFO]", color: :green },
      warn: { prefix: "[WARNING]", color: :yellow },
      error: { prefix: "[ERROR]", color: :red },
      debug: { prefix: "[DEBUG]", color: :blue },
    }.freeze

    def log(message, level: :info)
      formatted_log = format_log(message, level)
      puts formatted_log if formatted_log
    end

    private

    def format_log(message, level)
      details = LOG_DETAILS[level]
      raise ArgumentError, "Invalid log level: #{level}" unless details

      Utils::Color.colorize("#{details[:prefix]} #{message}", color: details[:color])
    end
  end
end
