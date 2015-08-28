require 'api_constraints'

Sil::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new( version: 1, default: true ) do
      # List of resources 
      resources :users, :only => [:index, :show, :create, :update, :destroy ]
      resources :sessions, :only => [:create, :destroy]
      resources :inventory_items, :only => [:index, :show]
    end
  end
end
