# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      include Utils::Construct::Component::Manager

      require_relative "base"
      require_relative "net_http"

      register_component(NetHttp)

      Utils::DependencyLoader.safe_load_dependencies(
        "faraday",
        on_failure: ->(_) {}, # Empty lambda to do nothing on failure
      ) do
        require_relative "faraday"
        register_component(Faraday)
      end
    end
  end
end
