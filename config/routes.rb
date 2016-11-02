Rails.application.routes.draw do
  get 'authen_accept/accept'

  # get 'profile/index'

  resources :news
  resources :posts
 # devise_for :users
  root to: "home#index"
  resources :profile, only: [:index]
  devise_for :users, :controllers => { :registrations => "registrations" }
  #devise_for :users, :controllers => { :registrations => "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
