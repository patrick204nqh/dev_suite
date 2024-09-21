# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    module Formatter
      class Graphql < Base
        def format_body(body)
          if body.is_a?(Hash) && body[:query] && body[:variables]
            { query: body[:query], variables: body[:variables] }.to_json
          elsif body.is_a?(String)
            { query: body, variables: {} }.to_json
          else
            raise ArgumentError, "Invalid GraphQL body format"
          end
        end
      end
    end
  end
end
