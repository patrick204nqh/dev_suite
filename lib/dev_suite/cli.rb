# frozen_string_literal: true

module DevSuite
  module CLI
    require "thor"

    require_relative "cli/commands"

    # Main CLI class
    require_relative "cli/main"
  end
end
