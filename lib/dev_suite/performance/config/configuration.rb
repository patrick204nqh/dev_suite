# frozen_string_literal: true

module DevSuite
  module Performance
    module Config
      class Configuration < Utils::Construct::Config::Base
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
          Profiler.build_components(value)
        end

        def resolve_reporter(value)
          Reporter.build_component(value)
        end
      end
    end
  end
end
