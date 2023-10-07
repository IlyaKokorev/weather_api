require 'rails_helper'

RSpec.describe AccuweatherApi::HistoricalWeatherService, type: :service do
  describe '#call' do
    context 'when correct work' do
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

    context 'when not correct work' do
      let(:invalid_location_key) { 'invalid_key' }

      it 'raises an AccuweatherServiceError' do
        VCR.use_cassette('returns_error_from_accuweather_for_historical') do
          expect { described_class.call(location_key: invalid_location_key) }
            .to raise_error(AccuweatherApi::BaseAccuweatherService::AccuweatherServiceError)
        end
      end
    end
  end
end
