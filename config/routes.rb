require 'api_constraints'

Sil::Application.routes.draw do
  # API definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new( version: 1, default: true ) do
      # List of resources 
    end
  end
end
