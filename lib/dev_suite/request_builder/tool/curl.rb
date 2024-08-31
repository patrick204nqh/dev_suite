# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      class Curl < Base
        def build_command(http_method:, url:, headers:, body: nil)
          # TODO: need to move those ones to config.settings
          use_insecure = false
          raw_data = false
          verbose = false
          follow_redirects = true
          cookie = nil
          user_agent = "Mozilla/5.0 (compatible; RequestBuilder/1.0)"
          max_time = nil
          connect_timeout = nil

          command = ["curl"]
          command << "-X #{http_method}"
          command << "'#{url}'"

          # Add headers
          headers.each do |key, value|
            command << "-H '#{key}: #{value}'"
          end

          # Add data payload
          command << (raw_data ? "--data-raw '#{body}'" : "-d '#{body}'") if body

          # Add other curl options
          command << "--insecure" if use_insecure
          command << "-v" if verbose
          command << "-L" if follow_redirects
          command << "-b '#{cookie}'" if cookie
          command << "-A '#{user_agent}'" if user_agent
          command << "--max-time #{max_time}" if max_time
          command << "--connect-timeout #{connect_timeout}" if connect_timeout

          command.join(" ").strip
        end
      end
    end
  end
end
