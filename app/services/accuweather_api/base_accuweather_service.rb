# frozen_string_literal: true

module AccuweatherApi
  class BaseAccuweatherService
    BASE_URL = Settings.accuweather.api.base_url
    DEFAULT_LOCATION_KEY = Settings.accuweather.location.default_location_key

    class AccuweatherServiceError < StandardError; end

    def initialize(location_key: nil)
      @api_key = Rails.application.credentials.accuweather[:api_key]
      @location_key = location_key || DEFAULT_LOCATION_KEY
    end

    protected

    def fetch_and_parse(uri, parser)
      response = fetch_data(uri)
      return parser.call(response.body) if response.is_a?(Net::HTTPSuccess)

      raise AccuweatherServiceError, "Failed fetch data. Response code: #{response.code}"
    end

    def uri_for(endpoint)
      uri = URI.join(BASE_URL, endpoint.gsub(':location_key', @location_key))
      uri.query = URI.encode_www_form(apikey: @api_key, details: 'false')
      uri
    end

    def fetch_data(uri)
      Net::HTTP.get_response(uri)
    end

    def extract_weather_data(weather_data)
      {
        temperature: weather_data.dig('Temperature', 'Metric', 'Value'),
        timestamp: DateTime.parse(weather_data['LocalObservationDateTime'])
      }
    end
  end
end
