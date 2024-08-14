# frozen_string_literal: true

module DevSuite
  module ErrorHandler
    def handle_error(error)
      log("🚨❌ Oops! An error occurred: #{error.message}", level: :error)
      log("💥 Please check the details and try again.", level: :error)
      exit(1)
    end
  end
end
