# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Config
      class Configuration < Utils::Construct::Config::Base
        set_default_settings(
          log_headers: true,
          log_cookies: true,
          log_body: true,
          log_level: :debug,
        )

        config_attr :adapters, default_value: [:net_http], type: :array, resolver: :resolve_adapters

        private

        def resolve_adapters(value)
          Adapter.build_components(value)
        end
      end
    end
  end
end
