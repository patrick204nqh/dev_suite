# frozen_string_literal: true

module DevSuite
  module ErrorHandler
    extend self # This makes all instance methods behave like class methods

    def handle_error(error)
      Logger.log(
        "🚨❌ Oops! An error occurred: #{error.message}",
        level: :error,
      )
      Logger.log(
        "📖 For more information, please refer to the README: " \
          "https://github.com/patrick204nqh/dev_suite",
        level: :error,
      )
      # exit(1)
    end
  end
end
