# frozen_string_literal: true

module ApiHelper
  BASE_HEADERS = { "Content-Type" => "application/json" }.freeze

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def post_json(path, params = {}, headers = {})
    request_json(:post, path, params, headers)
  end

  def get_json(path, params = {}, headers = {})
    request_json(:get, path, params, headers)
  end

  def put_json(path, params = {}, headers = {})
    request_json(:put, path, params, headers)
  end

  def delete_json(path, headers = {})
    request_json(:delete, path, {}, headers)
  end

  private

  def request_json(method, path, params = {}, headers = {})
    send(method, path, params: params.to_json, headers: BASE_HEADERS.merge(headers))
  end
end

RSpec.configure do |config|
  config.include(ApiHelper, type: :request)
end
