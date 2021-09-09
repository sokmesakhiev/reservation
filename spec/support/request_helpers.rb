module RequestHelpers
  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  def build_headers(user, additional_headers: {})
    api_key = create(:api_key, resource_owner: user)

    headers = additional_headers
    headers["HTTP_AUTHORIZATION"] = http_basic_auth(api_key.token)
    headers["CONTENT-TYPE"] = "application/json"

    headers
  end

  def http_basic_auth(username, password = "")
    ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
  config.include RequestHelpers, type: :controller
end

