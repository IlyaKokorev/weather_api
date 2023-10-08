source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'grape'
gem 'grape-entity'
gem 'groupdate'
gem 'config'
gem 'delayed_job_active_record'
gem 'rufus-scheduler' # Исключение в рамках ТЗ. Предпочитаю Sidekiq с Redis
gem 'grape-swagger-rails'
gem 'grape-swagger'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'webmock'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'vcr'
  gem 'pry'
end

group :development do
  gem "web-console"
end
