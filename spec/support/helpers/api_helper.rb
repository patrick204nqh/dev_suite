# frozen_string_literal: true

require "net/http"

module ApiHelper
  BASE_HEADERS = { "Content-Type" => "application/json" }.freeze

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_json(path, params = {}, headers = {})
    request_get(path, headers)
  end

  def post_json(path, params = {}, headers = {})
    request_post(path, params, headers)
  end

  def put_json(path, params = {}, headers = {})
    request_post(path, params, headers)
  end

  def delete_json(path, headers = {})
    request_delete(path, headers)
  end

  private

  def request_get(path, headers = {})
    request(:get, path, {}, headers)
  end

  def request_post(path, params = {}, headers = {})
    request(:post, path, params, headers)
  end

  def request_put(path, params = {}, headers = {})
    request(:put, path, params, headers)
  end

  def request_delete(path, headers = {})
    request(:delete, path, {}, headers)
  end

  def request(method, path, params = {}, headers = {})
    uri = URI(path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    request = build_request(method, uri, headers)
    request.body = params.to_json if [:post, :put].include?(method)

    @response = http.request(request) # Capture the response for use in helpers
  end

  def build_request(method, uri, headers)
    case method
    when :get
      Net::HTTP::Get.new(uri.request_uri, BASE_HEADERS.merge(headers))
    when :post
      Net::HTTP::Post.new(uri.request_uri, BASE_HEADERS.merge(headers))
    when :put
      Net::HTTP::Put.new(uri.request_uri, BASE_HEADERS.merge(headers))
    when :delete
      Net::HTTP::Delete.new(uri.request_uri, BASE_HEADERS.merge(headers))
    else
      raise ArgumentError, "Unsupported HTTP method: #{method}"
    end
  end

  def response
    @response
  end
end

RSpec.configure do |config|
  config.include(ApiHelper, type: :request)
end
