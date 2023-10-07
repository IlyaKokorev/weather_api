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

      namespace :historical do
        %i[max min avg].each do |method|
          get method.to_s do
            begin
              result = HistoricalWeatherCalculationService.call(method: method)
              { temperature: result.round(1) }
            rescue
              error!('Data is unavailable', 404)
            end
          end
        end
      end
    end
  end
end
