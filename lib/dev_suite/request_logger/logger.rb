# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Logger
      class << self
        def log_request(adapter, request)
          request = extract_request(adapter, request)
          log_entry(format_request_line(adapter, request), :start)
          log_headers(request) if settings.get(:log_headers)
          log_cookies(request) if settings.get(:log_cookies)
          log_body(request.body, "Request") if settings.get(:log_body)
        end

        def log_response(adapter, response)
          response = extract_response(adapter, response)
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

        def extract_request(adapter, request)
          extractor = Extractor.find_component(adapter)
          extractor.extract_request(request)
        end

        def extract_response(adapter, response)
          extractor = Extractor.find_component(adapter)
          extractor.extract_response(response)
        end

        def log_entry(message, emoji, level = settings.get(:log_level))
          Utils::Logger.log(message, level: level, emoji: emoji)
        end

        def determine_status_emoji(response)
          response.success? ? :success : :error
        end

        def determine_log_level(response)
          response.success? ? settings.get(:log_level) : :error
        end

        def format_request_line(adapter, request)
          "#{adapter.class} Request: #{request.method} #{request.url}"
        end

        def format_response_line(adapter, response)
          "#{adapter.class} Response: #{response.status} #{response.message}"
        end

        def log_headers(request)
          headers = request.headers
          log_entry("Headers: #{headers}", :document) unless headers.empty?
        end

        def log_cookies(request)
          cookies = request.cookies
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
