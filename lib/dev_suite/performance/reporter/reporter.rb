# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      include Utils::Construct::Component::Manager

      require_relative "base"
      require_relative "simple"
      require_relative "helpers"

      register_component(Simple)
    end
  end
end
