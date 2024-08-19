# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Logger
      class << self
        def log_request(adapter, request)
          DevSuite::Utils::Logger.log(
            "#{adapter.class} Request: #{request.method} #{request.uri}",
            level: :debug,
            emoji: :start,
          )
        end

        def log_response(adapter, response)
          DevSuite::Utils::Logger.log(
            "#{adapter.class} Response: #{response.code} #{response.message}",
            level: :debug,
            emoji: :start,
          )
        end
      end
    end
  end
end
