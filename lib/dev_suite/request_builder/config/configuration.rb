# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Config
      class Configuration < Utils::Construct::Config::Base
        set_default_settings(
          tool: {
            curl: {
              use_insecure: false,
              raw_data: false,
              verbose: false,
              follow_redirects: true,
              cookie: nil,
              user_agent: "Mozilla/5.0 (compatible; RequestBuilder/1.0)",
              max_time: nil,
              connect_timeout: nil,
            },
          },
        )
      end
    end
  end
end
