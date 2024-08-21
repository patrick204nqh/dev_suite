# frozen_string_literal: true

module DevSuite
  module Utils
    module ErrorHandler
      extend self # This makes all instance methods behave like class methods

      def handle_error(error)
        Utils::Logger.log(
          "Oops! An error occurred: #{error.message}",
          level: :error,
          emoji: :error,
        )
        Utils::Logger.log(
          "For more information, please refer to the README: " \
            "https://github.com/patrick204nqh/dev_suite",
          level: :error,
          emoji: :document,
        )
        # exit(1)
      end
    end
  end
end
