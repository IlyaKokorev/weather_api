# frozen_string_literal: true

class WeatherByTimeService < BaseService
  class WeatherByTimeServiceError < StandardError; end

  def call(timestamp:)
    desired_time = Time.at(timestamp.to_i).utc

    closest_weather = find_weather(desired_time)
    return closest_weather.temperature if closest_weather

    raise WeatherByTimeServiceError, "No weather data for timestamp"
  end

  private

  def find_weather(desired_time)
    order_sql = Arel.sql("ABS(EXTRACT(EPOCH FROM timestamp) - #{desired_time.to_i})")

    Weather.order(order_sql).limit(1).first
  end
end
