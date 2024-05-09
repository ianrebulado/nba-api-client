# frozen_string_literal: true

require 'faraday'

class NbaApi::V1::Client
  NBA_API_BASE_URL = 'https://api-nba-v1.p.rapidapi.com'
  API_KEY = Rails.application.credentials.nba_api.api_key

  def get_team(name)
    request(
      http_method: :get,
      endpoint: 'teams',
      params: { name: }
    )
  end

  def get_player(name) 
    request(
      http_method: :get,
      endpoint: 'players',
      params: { name: }
    )
  end

  private

  def client
    @client ||= begin
      options = {
        request: {
          open_timeout: 10,
          read_timeout: 10
        }
      }
      Faraday.new(url: NBA_API_BASE_URL, **options) do |config|
        config.headers['x-rapidapi-key'] = API_KEY
        config.request :json
        config.response :json, parser_options: { symbolize_names: true }
        config.response :raise_error
        config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end
  end

  def request(http_method:, endpoint:, params: {})
    response = client.public_send(http_method, endpoint, params)
    {
      status: response.status,
      body: response.body
    }
  rescue Faraday::Error => e
    raise Errors::ApiError.new(
      message: "API ERROR: #{e.message.capitalize}",
      faraday_error_class: e.class
    )
  end
end
