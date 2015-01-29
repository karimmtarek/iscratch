Rails.application.routes.draw do

  namespace :api, path: '/' do
    devise_for :users
  end


end
