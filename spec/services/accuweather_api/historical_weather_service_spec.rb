require 'rails_helper'

RSpec.describe AccuweatherApi::HistoricalWeatherService, type: :service do
  describe '#call' do
    it 'returns array of weather data for 24 hours' do
      response = nil

      VCR.use_cassette('returns_array_of_weather_data_for_24_hours') do
        response = described_class.call
      end

      expect(response).to be_an(Array)
      expect(response.size).to eq(24)
      expect(response.first).to have_key(:temperature)
      expect(response.first).to have_key(:timestamp)
    end
  end
end
