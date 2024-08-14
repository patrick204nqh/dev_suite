# frozen_string_literal: true

module DevSuite
  module ErrorHandler
    extend self # This makes all instance methods behave like class methods

    def handle_error(error)
      Logger.log("🚨❌ Oops! An error occurred: #{error.message}", level: :error)
      Logger.log("💥 Please check the details and try again.", level: :error)
      # exit(1)
    end
  end
end
