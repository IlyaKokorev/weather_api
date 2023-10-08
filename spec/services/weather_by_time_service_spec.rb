# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherByTimeService, type: :service do
  describe '#call' do
    let(:timestamp) { 1_621_823_790 }
    let(:desired_time) { Time.at(timestamp).utc }

    context 'when correct work' do
      let!(:nearest_weather) { create(:weather, timestamp: desired_time + 1.hours, temperature: 20.0) }
      let!(:farthest_weather) { create(:weather, timestamp: desired_time + 2.hours, temperature: 20.0) }

      it 'return nearest weather temperature' do
        result = described_class.new.call(timestamp:)
        expect(result).to eq(nearest_weather.temperature)
      end
    end

    context 'when not correct work' do
      it 'raise error if no weather data' do
        expect do
          described_class.new.call(timestamp:)
        end.to raise_error(WeatherByTimeService::WeatherByTimeServiceError, 'No weather data for timestamp')
      end
    end
  end
end
