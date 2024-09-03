# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Tool
      class Base < Utils::Construct::Component::Base
        def build_command(http_method:, url:, headers:, body: nil)
          raise NotImplementedError
        end

        private

        def fetch_setting(key, default: nil)
          Config.configuration.settings.get(key, default: default)
        end
      end
    end
  end
end
