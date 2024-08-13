# frozen_string_literal: true

module DevSuite
  require_relative "dev_suite/version"
  require_relative "dev_suite/logger"
  require_relative "dev_suite/error_handler"
  require_relative "dev_suite/utils"
  require_relative "dev_suite/cli"
  require_relative "dev_suite/performance"
  require_relative "dev_suite/directory_tree"

  class Error < StandardError; end
end
