# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      require_relative "base"
      require_relative "net_http"
      require_relative "faraday"

      include Utils::Construct::Component

      register_component(:net_http, NetHttp)
      register_component(:faraday, Faraday)
    end
  end
end
