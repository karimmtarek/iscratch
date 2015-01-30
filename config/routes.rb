Rails.application.routes.draw do

  namespace :api, path: '/', defaults: {format: :json} do
    namespace :v1 do
      resources :lists do
        resources :items
      end
    end
  end

  devise_for :users



end
