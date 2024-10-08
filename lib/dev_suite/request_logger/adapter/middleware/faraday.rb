# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Adapter
      module Middleware
        class Faraday < ::Faraday::Middleware
          def call(env, instance = nil)
            # Log the request details
            Logger.log_request(instance, env)

            # Perform the actual request
            @app.call(env).on_complete do |response_env|
              # Log the response details
              Logger.log_response(instance, response_env)
            end
          end
        end
      end
    end
  end
end
