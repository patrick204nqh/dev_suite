# frozen_string_literal: true

module DevSuite
  module Performance
    class Config
      include Utils::ConfigTools::Configuration

      # Define configuration attributes
      config_attr :profilers, default_value: [:execution_time, :memory]
      config_attr :reportor, default_value: :simple

      private

      def validate_attr!(attr, value)
        case attr
        when :profilers
          validate_array!(attr, value)
        when :reportor
          validate_symbol!(attr, value)
        else
          raise ArgumentError, "Invalid attribute: #{attr}"
        end
      end

      def resolve_attr(attr, value)
        case attr
        when :profilers
          Profiler.create_multiple(value)
        when :reportor
          Reportor.create(value)
        else
          value
        end
      end
    end
  end
end
