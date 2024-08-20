# frozen_string_literal: true

require "faraday"

module DevSuite
  module RequestLogger
    module Adapter
      require_relative "middleware/faraday"

      class Faraday < Base
        def enable
          ::Faraday::Connection.class_eval do
            alias_method(:_original_run_request, :run_request)

            def run_request(method, url, body, headers, &block)
              env = ::Faraday::Env.new(method, url, body, headers)
              env.request = @request
              env.params = @params
              env.request_body = @request_body
              env.ssl = @ssl
              env.response = @response

              Middleware::Faraday.new(lambda do |e|
                _original_run_request(e.method, e.url, e.body, e.request_headers, &block)
              end).call(env)
            end
          end
        end

        def disable
          ::Faraday::Connection.class_eval do
            alias_method(:run_request, :_original_run_request)
            remove_method(:_original_run_request)
          end
        end
      end
    end
  end
end
