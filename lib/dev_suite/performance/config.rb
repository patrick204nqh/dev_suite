# frozen_string_literal: true

module DevSuite
  module Performance
    class Config
      include Utils::ConfigTools::Configuration

      # Define configuration attributes
      config_attr :profilers, :reportor

      def initialize(profilers: [:execution_time, :memory], reportor: :simple)
        # Set default values for profilers and reportor.
        self.profilers = profilers
        self.reportor = reportor
      end

      private

      def validate_config_attr(attr, value)
        case attr
        when :profilers
          validate_profilers(value)
        when :reportor
          validate_reportor(value)
        end
      end

      def resolve_config_attr(attr, value)
        case attr
        when :profilers
          Profiler.create_multiple(value)
        when :reportor
          Reportor.create(value)
        else
          value
        end
      end

      def validate_profilers(value)
        unless value.is_a?(Array) && value.all? { |v| v.is_a?(Symbol) }
          raise ArgumentError, "Profilers must be an array of symbols"
        end
      end

      def validate_reportor(value)
        unless value.is_a?(Symbol)
          raise ArgumentError, "Invalid reportor value"
        end
      end
    end
  end
end
