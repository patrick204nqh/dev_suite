# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Config
      class Configuration < BaseConfiguration
        config_attr :adapters, default_value: [:net_http], type: :array, resolver: ->(value) {
                                                                                     Adapter.create_multiple(value)
                                                                                   }
      end
    end
  end
end
