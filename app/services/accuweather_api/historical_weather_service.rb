# frozen_string_literal: true

module AccuweatherApi
  class HistoricalWeatherService < BaseAccuweatherService
    HISTORICAL_CONDITIONS_ENDPOINT = Settings.accuweather.api.historical_conditions_endpoint

    def self.call(location_key: nil)
      new(location_key: location_key).send(:fetch_historical_weather)
    end

    private

    def fetch_historical_weather
      fetch_and_parse(historical_conditions_uri, method(:parse_historical_data))
    end

    def historical_conditions_uri
      uri_for(HISTORICAL_CONDITIONS_ENDPOINT)
    end

    def parse_historical_data(body)
      JSON.parse(body).map(&method(:extract_weather_data))
    end
  end
end
