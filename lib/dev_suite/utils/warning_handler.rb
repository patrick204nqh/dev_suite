# frozen_string_literal: true

module DevSuite
  module Utils
    module WarningHandler
      extend self

      def warn_if_missing(attribute_name, value)
        if value.nil? || (value.respond_to?(:empty?) && value.empty?)
          log_warning("#{attribute_name} is missing or empty!")
        end
      end

      private

      def log_warning(message)
        Utils::Logger.log(
          message,
          level: :warn,
          emoji: :warning,
        )
      end
    end
  end
end
