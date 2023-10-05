require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '24h' do
  AccuweatherJob.perform_later
end
