# frozen_string_literal: true

class HistoricalWeatherCalculationService < BaseService
  CALCULATION_METHODS = %i[max min avg]
  PERSISTENT_DATA_HOUR_COUNT = 20

  def initialize(method:)
    @method = method
  end

  def call
    calculate(@method)
  end

  def calculate(method)
    # На данном этапе бросать ексепшен избыточно, но осталяю для
    # возможности использовать сервис отдельно от контроллера
    raise ArgumentError, "Invalid calculation method" unless CALCULATION_METHODS.include?(method)

    ensure_data_availability
    public_send(method)
  end

  def max
    recent_weather_records.maximum(:temperature)
  end

  def min
    recent_weather_records.minimum(:temperature)
  end

  def avg
    recent_weather_records.average(:temperature)
  end

  private

  def ensure_data_availability
    # Для полной персистентности данных проверим, что за прошедшие сутки есть 80% записей о погоде
    # чтобы избежать кейса, когда в БД за первый час есть 24 записи, а за последующие - 0 (ну а вдруг)
    fetch_and_store_data unless data_persistent?
  end

  def fetch_and_store_data
    # Можно рассмотреть другие методы сохранения, если historical_data будет достаточно объемна по кол-ву записей
    historical_data = AccuweatherApi::HistoricalWeatherService.call
    historical_data.each do |data|
      Weather.create!(temperature: data[:temperature], timestamp: data[:timestamp])
    end
  end

  def data_persistent?
    hours_with_data.count > PERSISTENT_DATA_HOUR_COUNT
  end

  def hours_with_data
    recent_weather_records.group_by_hour_of_day(:timestamp).count.select { |_, v| v.positive? }.keys
  end

  def recent_weather_records
    Weather.where('timestamp > ?', 24.hours.ago)
  end
end
