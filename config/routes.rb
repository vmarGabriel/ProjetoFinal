require 'api_version_constraint'

Rails.application.routes.draw do
  
  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    namespace :api, defaults: {format: :json} do
        namespace :v1, path: "/", constraints: ApiVersionConstraint.new(version: 1) do
            resources :users
            resources :sessions
            resources :gains
            resources :expenses
        
        end
        
        namespace :v2, path: "/", constraints: ApiVersionConstraint.new(version: 2, default: true) do
            mount_devise_token_auth_for 'User', at: 'auth'
            resources :users
            resources :sessions
            resources :gains
            resources :expenses
        end
        
    end
end
