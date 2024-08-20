# frozen_string_literal: true

module DevSuite
  module Utils
    module Color
      module Palette
        require_relative "palette/base"
        require_relative "palette/default"

        include Construct::ComponentManager

        register_component(:default, Default)
      end
    end
  end
end
