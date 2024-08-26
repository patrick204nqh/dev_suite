# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Config
        include Construct::Config::Manager

        require_relative "configuration"
      end
    end
  end
end
