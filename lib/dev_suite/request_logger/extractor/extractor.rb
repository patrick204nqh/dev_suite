# frozen_string_literal: true

module DevSuite
  module RequestLogger
    module Extractor
      include Utils::Construct::ComponentManager

      require_relative "base"
      require_relative "net_http"

      register_component(::Net::HTTP, NetHttp)

      begin
        require_relative "faraday"
        register_component(::Faraday::Middleware, Faraday)
      rescue LoadError
        Utils::Logger.log(
          "Faraday gem not installed. Skipping Faraday adapter registration.",
          level: :warn,
          emoji: :warning,
        )
        Utils::Logger.log(
          "To install Faraday, add `gem 'faraday'` to your Gemfile and run `bundle install`.",
          level: :warn,
          emoji: :update,
        )
      end
    end
  end
end
