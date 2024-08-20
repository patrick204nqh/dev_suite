# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      require_relative "base"
      require_relative "net_http"
      require_relative "faraday"

      class << self
        def choose_extractor(instance)
          case instance
          when ::Net::HTTP
            NetHttp.new
          when ::Faraday::Middleware
            Faraday.new
          else
            raise ArgumentError, "Extractor not found for instance: #{instance.class}"
          end
        end
      end
    end
  end
end
