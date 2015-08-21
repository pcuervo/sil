require 'api_constraints'

Sil::Application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new( version: 1, default: true ) do
      # List of resources 
      resources :users, :only => [:show, :create, :update, :destroy]
    end
  end
end
