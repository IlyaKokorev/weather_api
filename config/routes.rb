# frozen_string_literal: true

Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Api => '/'
end
