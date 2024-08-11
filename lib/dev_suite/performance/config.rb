# frozen_string_literal: true

module DevSuite
  module Performance
    class Config
      include Utils::ConfigTools::Configuration

      attr_reader :reportor

      def initialize(reportor: :simple)
        @reportor = Reportor.create(reportor)
        freeze # Make the instance of this class immutable
      end
    end
  end
end
