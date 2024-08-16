# frozen_string_literal: true

module DevSuite
  module Utils
    module Table
      module Config
        include Construct::Config

        require_relative "configuration"
        require_relative "settings"
      end
    end
  end
end
