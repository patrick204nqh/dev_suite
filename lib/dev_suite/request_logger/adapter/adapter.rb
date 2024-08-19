module DevSuite
  module RequestLogger
    module Adapter
      require "net/http"

      require_relative "base"
      require_relative "net_http"

      class << self
        def create(adapter)
          case adapter
          when :net_http
            NetHttp.new
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
