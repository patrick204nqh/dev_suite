# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      include Utils::Construct::Component::Manager

      require_relative "base"

      load_dependency(["net/http"], on_failure: ->(_) {}) do
        require_relative "net_http"
        register_component(NetHttp)
      end

      load_dependency(["faraday"], on_failure: ->(_) {}) do
        require_relative "faraday"
        register_component(Faraday)
      end
    end
  end
end
