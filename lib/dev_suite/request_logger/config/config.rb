# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Config
      include Utils::Construct::Config

      require_relative "configuration"
    end
  end
end
