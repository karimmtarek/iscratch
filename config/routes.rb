Rails.application.routes.draw do

  namespace :api, path: '/', defaults: {format: :json} do
    namespace :v1 do
      resources :users
      resources :lists do
        get :view_all, on: :collection
        resources :items
      end
    end
  end

end
