# frozen_string_literal: true

module DevSuite
  module Performance
    module Reporter
      require_relative "reporter/base"
      require_relative "reporter/simple"
      require_relative "reporter/helpers"

      include Utils::Construct::ComponentManager

      register_component(:simple, Simple)
    end
  end
end
