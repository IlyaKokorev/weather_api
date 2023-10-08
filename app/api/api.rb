require 'grape-swagger'

class Api < Grape::API
  format :json

  mount V1::Weather

  add_swagger_documentation
end
