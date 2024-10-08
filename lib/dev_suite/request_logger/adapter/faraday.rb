# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      require_relative "middleware/faraday"

      class Faraday < Base
        def enable
          return unless faraday_defined?

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
              end).call(env, self)
            end
          end
        end

        def disable
          return unless faraday_defined?

          ::Faraday::Connection.class_eval do
            alias_method(:run_request, :_original_run_request)
            remove_method(:_original_run_request)
          end
        end

        private

        # Check if Faraday is defined
        def faraday_defined?
          defined?(::Faraday::Connection) && defined?(::Faraday::Env)
        end
      end
    end
  end
end
