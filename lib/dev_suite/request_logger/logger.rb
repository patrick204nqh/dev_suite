# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Logger
      class << self
        def log_request(instance, request)
          request = extract_request(instance, request)
          log_entry(format_request_line(instance, request), :start)
          log_headers(request) if settings.get(:log_headers)
          log_cookies(request) if settings.get(:log_cookies)
          log_body(request.body, "Request") if settings.get(:log_body)
        end

        def log_response(instance, response)
          response = extract_response(instance, response)
          status_emoji = determine_status_emoji(response)
          log_level = determine_log_level(response)

          log_entry(format_response_line(instance, response), status_emoji, log_level)
          log_headers(response) if settings.get(:log_headers)
          log_body(response.body, "Response") if settings.get(:log_body)
          log_response_time(response) if settings.get(:log_response_time)
        end

        private

        def config
          Config.configuration
        end

        def settings
          config.settings
        end

        def extract_request(instance, request)
          extractor = Extractor.build_component_from_instance(instance)
          extractor.extract_request(instance, request)
        end

        def extract_response(instance, response)
          extractor = Extractor.build_component_from_instance(instance)
          extractor.extract_response(instance, response)
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
          log_entry("Headers: #{headers}", :document)
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

        def log_response_time(response)
          response_time = response.response_time
          log_entry("Response Time: #{response_time} seconds", :stop) if response_time
        end
      end
    end
  end
end
