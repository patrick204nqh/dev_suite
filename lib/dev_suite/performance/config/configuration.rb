# frozen_string_literal: true

module DevSuite
  module Performance
    module Config
      class Configuration < BaseConfiguration
        # Define configuration attributes
        config_attr :profilers,
          default_value: [:execution_time, :memory],
          type: :array,
          resolver: ->(value) { Profiler.create_multiple(value) }

        config_attr :reporter,
          default_value: :simple,
          type: :symbol,
          resolver: ->(value) { Reporter.create(value) }
      end
    end
  end
end
