# frozen_string_literal: true

module DevSuite
  module Utils
    PATH = "dev_suite/utils"

    # Load essential modules immediately because they are critical for
    # application startup and early functionality.
    require_relative "emoji"
    require_relative "logger"
    require_relative "data"
    require_relative "error_handler"
    require_relative "warning_handler"
    require_relative "dependency_loader"

    # Core utilities
    autoload :Construct, "#{PATH}/construct"

    # Functional utilities
    autoload :Store, "#{PATH}/store"
    autoload :Color, "#{PATH}/color"
    autoload :Table, "#{PATH}/table"
    autoload :FileLoader, "#{PATH}/file_loader"
    autoload :FileWriter, "#{PATH}/file_writer"
    autoload :PathMatcher, "#{PATH}/path_matcher"
  end
end
