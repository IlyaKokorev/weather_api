# frozen_string_literal: true

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '24h' do
  FetchAndStoreWeatherDataJob.perform_later
end
