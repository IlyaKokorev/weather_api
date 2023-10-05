class Api < Grape::API
  format :json

  mount V1::Weather
end
