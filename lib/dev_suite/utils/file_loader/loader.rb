# frozen_string_literal: true

module DevSuite
  module Utils
    module FileLoader
      module Loader
        include Construct::Component

        require_relative "loader/loader"
      end
    end
  end
end
