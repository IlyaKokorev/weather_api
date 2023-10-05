require 'rails_helper'
require 'vcr'

RSpec.describe AccuweatherApi::CurrentWeatherService, type: :service do
  describe '#call' do
    it 'returns current weather data' do
      response = nil

      VCR.use_cassette('returns_current_weather_data') do
        response = described_class.call
      end

      expect(response).to have_key(:temperature)
      expect(response).to have_key(:timestamp)
    end
  end
end
