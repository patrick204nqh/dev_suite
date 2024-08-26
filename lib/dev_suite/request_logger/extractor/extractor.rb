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
        on_failure: ->(missing_dependencies) {
          Config.configuration.delete_option_on_failure(:adapters, :faraday, *missing_dependencies)
        },
      ) do
        require_relative "faraday"
        register_component(Faraday)
      end
    end
  end
end
