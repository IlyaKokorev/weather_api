# frozen_string_literal: true

class FetchAndStoreWeatherDataJob < ApplicationJob
  queue_as :default

  def perform
    # Можно рассмотреть другие методы сохранения, если historical_data будет достаточно объемна по кол-ву записей
    historical_data = AccuweatherApi::HistoricalWeatherService.call
    historical_data.each do |data|
      Weather.create!(temperature: data[:temperature], timestamp: data[:timestamp])
    end
  end
end
