Rails.application.routes.draw do
  # get 'profile/index'

  resources :news
  resources :posts
  devise_for :users
  root to: "home#index"
  resources :profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
