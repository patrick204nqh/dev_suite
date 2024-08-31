# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      class Curl < Base
        def build_command(http_method:, url:, headers:, body: nil)
          command = ["curl"]
          command << "-X #{http_method}"
          command << "'#{url}'"

          add_headers(command, headers)
          add_body(command, body)
          add_curl_options(command)

          command.join(" ").strip
        end

        private

        def add_headers(command, headers)
          headers.each do |key, value|
            command << "-H '#{key}: #{value}'"
          end
        end

        def add_body(command, body)
          return unless body

          command << (raw_data? ? "--data-raw '#{body}'" : "-d '#{body}'")
        end

        def add_curl_options(command)
          append_option(command, "--insecure", "tool.curl.use_insecure")
          append_option(command, "-v", "tool.curl.verbose")
          append_option(command, "-L", "tool.curl.follow_redirects", default: true)
          append_option(command, "-b '#{fetch_setting("tool.curl.cookie")}'", "tool.curl.cookie")
          append_option(command, "-A '#{fetch_setting("tool.curl.user_agent")}'", "tool.curl.user_agent")
          append_option(command, "--max-time #{fetch_setting("tool.curl.max_time")}", "tool.curl.max_time")
          append_option(
            command,
            "--connect-timeout #{fetch_setting("tool.curl.connect_timeout")}",
            "tool.curl.connect_timeout",
          )
        end

        def raw_data?
          fetch_setting("tool.curl.raw_data", false)
        end

        def append_option(command, option, setting_key, default: nil)
          value = fetch_setting(setting_key, default)
          command << option if value
        end
      end
    end
  end
end
