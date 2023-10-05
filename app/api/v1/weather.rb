module V1
  class Weather < Grape::API
    resource :weather do
      get 'current' do
        current_weather = AccuweatherApi::CurrentWeatherService.call
        present current_weather, with: V1::Entities::WeatherEntity
      end

      get 'historical' do
        historical_weather = AccuweatherApi::HistoricalWeatherService.call
        present historical_weather, with: V1::Entities::WeatherEntity
      end
    end
  end
end
