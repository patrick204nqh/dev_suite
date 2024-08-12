# frozen_string_literal: true

module DevSuite
  module Performance
    class Config
      include Utils::ConfigTools::Configuration

      attr_reader :profilers, :reportor

      def initialize(profilers: [:execution_time, :memory], reportor: :simple)
        @profilers = Profiler.create_multiple(profilers)
        @reportor = Reportor.create(reportor)
        freeze # Make the instance of this class immutable
      end
    end
  end
end
