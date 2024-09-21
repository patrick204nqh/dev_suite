# frozen_string_literal: true

module DevSuite
  module Utils
    module Store
      module Config
        class Configuration < Utils::Construct::Config::Base
          set_default_settings(
            driver: {
              file: {
                path: "#{Dir.pwd}/tmp/store.json",
              },
            },
          )

          config_attr :driver,
            default_value: :memory,
            type: :symbol,
            resolver: :resolve_driver

          private

          def resolve_driver(value)
            Driver.build_component(value)
          end
        end
      end
    end
  end
end
