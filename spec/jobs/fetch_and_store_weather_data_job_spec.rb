require 'rails_helper'
require 'vcr'

RSpec.describe FetchAndStoreWeatherDataJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform_later' do
    it 'adds jobs to the queue' do
      assert_enqueued_with(job: FetchAndStoreWeatherDataJob) do
        FetchAndStoreWeatherDataJob.perform_later
      end
    end

    it 'creates weather records from historical data' do
      VCR.use_cassette('returns_array_of_weather_data_for_24_hours') do
        perform_enqueued_jobs { FetchAndStoreWeatherDataJob.perform_later }
      end

      expect(Weather.count).to eq(24)
      expect(Weather.last.temperature).not_to be_nil
      expect(Weather.last.timestamp).not_to be_nil
    end
  end
end
