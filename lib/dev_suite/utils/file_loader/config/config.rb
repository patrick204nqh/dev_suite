# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Config
        include Construct::Config

        require_relative "configuration"
      end
    end
  end
end
