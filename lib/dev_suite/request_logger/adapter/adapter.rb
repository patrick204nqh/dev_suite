# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      include Utils::Construct::Component::Manager

      require_relative "base"

      class << self
        def handle_missing_nethttp(missing_dependencies)
          Config.configuration.remove_failed_dependency(:adapters, :net_http, *missing_dependencies)
        end

        def handle_missing_faraday(missing_dependencies)
          Config.configuration.remove_failed_dependency(:adapters, :faraday, *missing_dependencies)
        end
      end

      # Load and register `net/http` adapter
      load_dependency(["net/http"], on_failure: method(:handle_missing_nethttp)) do
        require_relative "net_http"
        register_component(NetHttp)
      end

      # Load and register `faraday` adapter
      load_dependency(["faraday"], on_failure: method(:handle_missing_faraday)) do
        require_relative "faraday"
        register_component(Faraday)
      end
    end
  end
end
