# frozen_string_literal: true

module DevSuite
  module ErrorHandler
    def handle_error(error)
      log("Error: #{error.message}", level: :error)
      exit(1)
    end
  end
end
