require 'api_constraints'

Sil::Application.routes.draw do
  devise_for :users
  # API definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new( version: 1, default: true ) do
      # List of resources 
      resources :users, :only => [:index, :show, :create, :update, :destroy] do
        resources :inventory_items, :only => [:create]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :inventory_items, :only => [:index, :show]
      resources :projects, :only => [:index, :show, :create, :destroy]
      #  do
      #   collection do 
      #     get 'show_unit_item/:id', :action => 'show_unit_item'
      #   end
      # end

    end
  end

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1 , default: true) do
      resources :users, :only => [:index, :show, :create, :update]
    end
  end


  #get '/users', to: 'api/v1/users#index'
  
end
