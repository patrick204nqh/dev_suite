# frozen_string_literal: true

module APIHelper
  require "net/http"
  require "uri"

  class << self
    def make_post_request(endpoint:, headers:, body_data:, success_criteria: nil)
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = URI.encode_www_form(body_data)

      response = http.request(request)
      parsed_response = JSON.parse(response.body)

      success = if success_criteria
        success_criteria.call(parsed_response)
      else
        response.is_a?(Net::HTTPSuccess)
      end

      { success: success, response: parsed_response }
    rescue StandardError => e
      DevSuite::Utils::Logger.log("Error during POST request: #{e.message}", level: :error)
      { success: false, error: e.message }
    end

    def make_get_request(endpoint:, headers:, success_criteria: nil)
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri, headers)

      response = http.request(request)
      parsed_response = JSON.parse(response.body)

      success = if success_criteria
        success_criteria.call(parsed_response)
      else
        response.is_a?(Net::HTTPSuccess)
      end

      { success: success, response: parsed_response }
    rescue StandardError => e
      DevSuite::Utils::Logger.log("Error during GET request: #{e.message}", level: :error)
      { success: false, error: e.message }
    end
  end
end
