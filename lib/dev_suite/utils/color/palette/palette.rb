# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        include Construct::Component::Manager

        require_relative "base"
        require_relative "default"

        register_component(Default)
      end
    end
  end
end
