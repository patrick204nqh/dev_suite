# frozen_string_literal: true

module DevSuite
  module Workflow
    class Logger
      LOG_FILE = "log/workflow.log"

      class << self
        def log(step_name, message)
          # TODO: Implement logging
          # ::File.open(LOG_FILE, "a") do |f|
          #   f.puts("#{Time.now} - Step: #{step_name}, Message: #{message}")
          # end
        end
      end
    end
  end
end
