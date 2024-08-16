# frozen_string_literal: true

module DevSuite
  module Performance
    module Config
      class Configuration < BaseConfiguration
        # Define configuration attributes
        config_attr :profilers, default_value: [:execution_time, :memory]
        config_attr :reporter, default_value: :simple

        private

        def validate_attr!(attr, value)
          case attr
          when :profilers
            validate_array!(attr, value)
          when :reporter
            validate_symbol!(attr, value)
          else
            super
          end
        end

        def resolve_attr(attr, value)
          case attr
          when :profilers
            Profiler.create_multiple(value)
          when :reporter
            Reporter.create(value)
          else
            super
          end
        end
      end
    end
  end
end
