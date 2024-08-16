# frozen_string_literal: true

module DevSuite
  module DirectoryTree
    module Config
      include Utils::Construct::Config

      require_relative "configuration"
      require_relative "settings"
    end
  end
end
