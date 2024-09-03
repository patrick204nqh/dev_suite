# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      class Curl < Base
        def build_command(http_method:, url:, headers:, body: nil)
          validate_parameters(http_method, url, headers, body)

          command = build_base_command(http_method, url)

          add_headers(command, headers)
          add_body(command, body)
          add_insecure_option(command)
          add_verbose_option(command)
          add_follow_redirects_option(command)
          add_cookie_option(command)
          add_user_agent_option(command)
          add_max_time_option(command)
          add_connect_timeout_option(command)

          command.join(" ").strip
        end

        private

        def validate_parameters(http_method, url, headers, body)
          validator = Validator::Curl.new
          validator.validate!(
            http_method: http_method,
            url: url,
            headers: headers,
            body: body,
          )
        end

        def build_base_command(http_method, url)
          ["curl", "-X #{http_method}", "'#{url}'"]
        end

        def add_headers(command, headers)
          headers.each do |key, value|
            command << "-H '#{key}: #{value}'"
          end
        end

        def add_body(command, body)
          return unless body

          command << (raw_data? ? "--data-raw '#{body}'" : "-d '#{body}'")
        end

        def add_insecure_option(command)
          command << "--insecure" if fetch_setting("tool.curl.use_insecure", default: false)
        end

        def add_verbose_option(command)
          command << "-v" if fetch_setting("tool.curl.verbose", default: false)
        end

        def add_follow_redirects_option(command)
          command << "-L" if fetch_setting("tool.curl.follow_redirects", default: true)
        end

        def add_cookie_option(command)
          cookie = fetch_setting("tool.curl.cookie")
          command << "-b '#{cookie}'" if cookie
        end

        def add_user_agent_option(command)
          user_agent = fetch_setting("tool.curl.user_agent")
          command << "-A '#{user_agent}'" if user_agent
        end

        def add_max_time_option(command)
          max_time = fetch_setting("tool.curl.max_time")
          command << "--max-time #{max_time}" if max_time
        end

        def add_connect_timeout_option(command)
          connect_timeout = fetch_setting("tool.curl.connect_timeout")
          command << "--connect-timeout #{connect_timeout}" if connect_timeout
        end

        def raw_data?
          fetch_setting("tool.curl.raw_data", default: false)
        end
      end
    end
  end
end
