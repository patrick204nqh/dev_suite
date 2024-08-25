# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      require_relative "base"
      require_relative "net_http"
      require_relative "faraday"

      include Utils::Construct::Component

      class << self
        def choose_extractor(instance)
          extractor_class = registered_components.find do |klass, _|
            instance.is_a?(klass)
          end

          raise ArgumentError, "Extractor not found for instance: #{instance.class}" unless extractor_class

          extractor_class.last.new
        end
      end

      register_component(::Net::HTTP, NetHttp)
      register_component(::Faraday::Middleware, Faraday)
    end
  end
end
