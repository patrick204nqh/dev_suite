# frozen_string_literal: true

module DevSuite
  module RequestBuilder
    require_relative "formatter"
    require_relative "generator"

    class << self
      # Generates a request using the specified tool and format.
      #
      # @param tool [Symbol] the tool to use for generating the request
      # @param format [Symbol] the format to use for the request
      # @param url [String] the URL for the request
      # @param method [Symbol] the HTTP method for the request (default: :get)
      # @param headers [Hash] the headers for the request (default: {})
      # @param cookies [Hash] the cookies for the request (default: {})
      # @param params [Hash] the parameters for the request (default: {})
      # @param body [String, nil] the body of the request (default: nil)
      # @param data [Hash] additional data for the request (default: {})
      # @param options [Hash] additional options for the request (default: {})
      # @return [Object] the generated request
      def generate(
        tool:,
        format:,
        url:,
        method: :get,
        headers: {},
        cookies: {},
        params: {},
        body: nil,
        data: {},
        options: {}
      )
        generator = select_generator(tool)
        formatter = select_formatter(format)

        formatted_data = formatter.format_request(
          method: method,
          url: url,
          headers: headers,
          cookies: cookies,
          params: params,
          body: body,
          data: data,
          options: options,
        )

        generator.generate_request(
          url: url_with_params(url, params),
          method: method,
          headers: headers,
          cookies: cookies,
          body: formatted_data,
        )
      end

      private

      def select_formatter(format)
        case format
        when :graphql
          Formatter::GraphQL
        else
          raise NotImplementedError
        end
      end

      def select_generator(tool)
        case tool
        when :curl
          Generator::Curl
        else
          raise NotImplementedError
        end
      end

      def url_with_params(url, params)
        return url if params.empty?

        uri = URI.parse(url)
        uri.query = URI.encode_www_form(params)
        uri.to_s
      end
    end
  end
end
