class AccuweatherJob < ApplicationJob
  queue_as :default

  def perform
    historical_data = AccuweatherApi::HistoricalWeatherService.call
    historical_data.each do |data|
      Weather.create!(temperature: data[:temperature], timestamp: data[:timestamp])
    end
  end
end
