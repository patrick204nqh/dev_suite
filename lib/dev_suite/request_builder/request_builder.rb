# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    require_relative "formatter"
    require_relative "tool"
    require_relative "builder"

    class << self
      def build(protocol:, tool:, **options)
        case protocol
        when :http
          Builder::Http.new(tool: tool, **options)
        else
          raise ArgumentError, "Unknown protocol: #{protocol}"
        end
      end
    end
  end
end
