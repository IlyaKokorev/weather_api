# frozen_string_literal: true

module AccuweatherApi
  class CurrentWeatherService < BaseAccuweatherService
    CURRENT_CONDITIONS_ENDPOINT = Settings.accuweather.api.current_conditions_endpoint

    def self.call(location_key: nil)
      new(location_key: location_key).send(:fetch_current_weather)
    end

    private

    def fetch_current_weather
      fetch_and_parse(current_conditions_uri, method(:parse_current_data))
    end

    def current_conditions_uri
      uri_for(CURRENT_CONDITIONS_ENDPOINT)
    end

    def parse_current_data(body)
      weather_data = JSON.parse(body).first
      extract_weather_data(weather_data)
    end
  end
end
