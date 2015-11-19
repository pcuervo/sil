require 'api_constraints'

Sil::Application.routes.draw do
  devise_for :users
  # API definition
  # namespace :api, defaults: { format: :json },
  #                             constraints: { subdomain: 'api' }, path: '/' do
  #   scope module: :v1,
  #                 constraints: ApiConstraints.new( version: 1, default: true ) do
  #     # List of resources 
  #     resources :users, :only => [:index, :show, :create, :update, :destroy] do
  #       resources :inventory_items, :only => [:create]
  #       resources :unit_items, :only => [:create]
  #       collection do 
  #         get 'get_project_managers/', :action => 'get_project_managers'
  #         get 'get_account_executives/', :action => 'get_account_executives'
  #       end
  #     end
  #     resources :sessions, :only => [:create, :destroy]
  #     resources :inventory_items, :only => [:index, :show]
  #     resources :unit_items, :only => [:index, :show]
  #     resources :projects, :only => [:index, :show, :create, :update, :destroy] do
  #       collection do 
  #         get 'get_project_users/:id', :action => 'get_project_users'
  #         get 'get_project_client/:id', :action => 'get_project_users'
  #       end
  #     end
  #     resources :clients, :only => [:show, :index, :create, :update, :destroy]
  #     resources :client_contacts, :only => [:show, :index, :create, :update, :destroy] do
  #       get 'get_contacts_by_client/', :action => 'get_contacts_by_client'
  #     end
      
  #   end
  # end

  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1 , default: true) do
      
      resources :users, :only => [:index, :show, :create, :update, :destroy] do
        collection do 
          post 'update/', :action => 'update'
        end
        resources :inventory_items, :only => [:create]
        resources :unit_items, :only => [:create]
          collection do 
            get 'get_project_managers/', :action => 'get_project_managers'
            get 'get_account_executives/', :action => 'get_account_executives'
          end
        resources :bulk_items, :only => [:create]
        resources :bundle_items, :only => [:create]
      end
      resources :sessions, :only => [:create, :destroy] do
        collection do
          post 'destroy/', :action => 'destroy'
        end
      end
      resources :inventory_items, :only => [:index, :show]
      resources :unit_items, :only => [:index, :show]
      resources :bulk_items, :only => [:index, :show]
      resources :bundle_items, :only => [:index, :show]
      resources :projects, :only => [:index, :show, :create, :update, :destroy] do
        collection do 
          get 'get_project_users/:id', :action => 'get_project_users'
          get 'get_project_client/:id', :action => 'get_project_client'
        end
      end
      resources :clients, :only => [:show, :index, :create, :update, :destroy]
      resources :client_contacts, :only => [:show, :index, :create, :update, :destroy] do
        get 'get_contacts_by_client/', :action => 'get_contacts_by_client'
      end
      resources :inventory_transactions, :only => [:show, :index]
    end
  end


  #get '/users', to: 'api/v1/users#index'
  
end
