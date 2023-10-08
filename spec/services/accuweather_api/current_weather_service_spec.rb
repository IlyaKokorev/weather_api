# frozen_string_literal: true

require 'rails_helper'
require 'vcr'

RSpec.describe AccuweatherApi::CurrentWeatherService, type: :service do
  describe '#call' do
    context 'when correct work' do
      it 'returns current weather data' do
        response = nil

        VCR.use_cassette('returns_current_weather_data') do
          response = described_class.call
        end

        expect(response).to have_key(:temperature)
        expect(response).to have_key(:timestamp)
      end
    end

    context 'when not correct work' do
      let(:invalid_location_key) { 'invalid_key' }

      it 'raises an AccuweatherServiceError' do
        VCR.use_cassette('returns_error_from_accuweather_for_current') do
          expect { described_class.call(location_key: invalid_location_key) }
            .to raise_error(AccuweatherApi::BaseAccuweatherService::AccuweatherServiceError)
        end
      end
    end
  end
end
