# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      require "net/http"
      require "faraday"

      require_relative "base"
      require_relative "net_http"
      require_relative "faraday"

      include Utils::Construct::ComponentManager

      register_component(:net_http, NetHttp)
      register_component(:faraday, Faraday)
    end
  end
end
