# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      require "net/http"
      require "faraday"

      require_relative "base"
      require_relative "net_http"
      require_relative "faraday"

      class << self
        def create(adapter)
          case adapter
          when :net_http
            NetHttp.new
          when :faraday
            Faraday.new
          else
            raise ArgumentError, "Adapter not found: #{adapter}"
          end
        end

        def create_multiple(adapters)
          adapters.map { |adapter| create(adapter) }
        end
      end
    end
  end
end
