# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Logger
      class << self
        def log_request(adapter, request)
          log_entry(format_request_line(adapter, request), :start)
          log_headers(request) if settings.get(:log_headers)
          log_cookies(request) if settings.get(:log_cookies)
          log_body(request.body, "Request") if settings.get(:log_body)
        end

        def log_response(adapter, response)
          status_emoji = determine_status_emoji(response)
          log_level = determine_log_level(response)

          log_entry(format_response_line(adapter, response), status_emoji, log_level)
          log_headers(response) if settings.get(:log_headers)
          log_body(response.body, "Response") if settings.get(:log_body)
        end

        private

        def config
          Config.configuration
        end

        def settings
          config.settings
        end

        def log_entry(message, emoji, level = settings.get(:log_level))
          Utils::Logger.log(message, level: level, emoji: emoji)
        end

        def determine_status_emoji(response)
          response_success?(response) ? :success : :error
        end

        def determine_log_level(response)
          response_success?(response) ? settings.get(:log_level) : :error
        end

        def response_success?(response)
          response.code.to_i.between?(200, 299)
        end

        def extract_headers(request)
          request.each_header.to_h
        end

        def extract_cookies(request)
          if request.respond_to?(:to_hash) && request.to_hash["cookie"]
            request.to_hash["cookie"]
          elsif request.respond_to?(:headers) && request.headers["Cookie"]
            [request.headers["Cookie"]]
          else
            []
          end
        end

        def format_request_line(adapter, request)
          "#{adapter.class} Request: #{request.method} #{request.uri}"
        end

        def format_response_line(adapter, response)
          "#{adapter.class} Response: #{response.code} #{response.message}"
        end

        def log_headers(request)
          headers = extract_headers(request)
          log_entry("Headers: #{headers}", :document) unless headers.empty?
        end

        def log_cookies(request)
          cookies = extract_cookies(request)
          if cookies.any?
            log_entry("Cookies: #{cookies.join("; ")}", :cookie)
          else
            log_entry("Cookies: None", :cookie)
          end
        end

        def log_body(body, type)
          return unless body && !body.empty?

          log_entry("#{type} Body: #{body}", :code)
        end
      end
    end
  end
end
