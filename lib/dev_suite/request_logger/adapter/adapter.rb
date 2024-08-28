# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      include Utils::Construct::Component::Manager

      require_relative "base"

      class << self
        def handle_missing_dependencies(missing_dependencies)
          Config.configuration.remove_failed_dependency_option(:adapters, :faraday, *missing_dependencies)
        end
      end

      # Load and register `net/http` adapter
      require "net/http"
      require_relative "net_http"
      register_component(NetHttp)

      # Load and register `faraday` adapter
      Utils::DependencyLoader.safe_load_dependencies(
        "faraday",
        on_failure: method(:handle_missing_dependencies),
      ) do
        require_relative "faraday"
        register_component(Faraday)
      end
    end
  end
end
