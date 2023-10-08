require 'rails_helper'

RSpec.describe HistoricalWeatherCalculationService, type: :service do
  describe '#calculate' do
    context 'with invalid method' do
      it 'raise error' do
        expect { described_class.call(method: :invalid_method) }
          .to raise_error(ArgumentError, "Invalid calculation method")
      end
    end
  end

  describe 'calculation methods' do
    let!(:weather_data) { FactoryBot.create(:weather, :for_last_24_hours) }

    describe '#max' do
      let(:max_temperature) { Weather.maximum(:temperature).to_f }

      it 'return record with maximum temperature' do
        expect(described_class.call(method: :max)).to eq(max_temperature)
      end
    end

    describe '#min' do
      let(:min_temperature) { Weather.minimum(:temperature).to_f }

      it 'return record with minimum temperature' do
        expect(described_class.call(method: :min)).to eq(min_temperature)
      end
    end

    describe '#avg' do
      let(:average_temperature) { Weather.average(:temperature).to_f }

      it 'return average temperature' do
        expect(described_class.call(method: :avg)).to eq(average_temperature)
      end
    end
  end

  describe '#ensure_data_availability' do
    before { allow(AccuweatherApi::HistoricalWeatherService).to receive(:call).and_return([]) }

    context 'when data for last 24 hours present in db' do
      let!(:weather_data) { FactoryBot.create(:weather, :for_last_24_hours) }

      it 'not call accuweather API' do
        described_class.call(method: :max)
        expect(AccuweatherApi::HistoricalWeatherService).not_to have_received(:call)
      end
    end

    context 'when data for last 24 hours not persisted' do
      let!(:weather_data) { FactoryBot.create(:weather) }

      it 'call accuweather API and fetch missing data' do
        described_class.call(method: :max)
        expect(AccuweatherApi::HistoricalWeatherService).to have_received(:call)
      end
    end
  end
end
