# frozen_string_literal: true

module DevSuite
  module Performance
    module Config
      class Configuration < BaseConfiguration
        # Define configuration attributes
        config_attr :profilers,
          default_value: [:execution_time, :memory],
          type: :array,
          resolver: :resolve_profilers

        config_attr :reporter,
          default_value: :simple,
          type: :symbol,
          resolver: :resolve_reporter

        private

        def resolve_profilers(value)
          Profiler.create_multiple(value)
        end

        def resolve_reporter(value)
          Reporter.create(value)
        end
      end
    end
  end
end
