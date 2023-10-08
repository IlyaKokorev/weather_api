# frozen_string_literal: true

require 'grape_entity'

module V1
  module Entities
    class WeatherEntity < Grape::Entity
      expose :temperature
      expose :timestamp
    end
  end
end
