Rails.application.routes.draw do
  resources :galleries
  post 'galleries/update', :to => 'galleries#update'
  # get 'profile/index'
  post 'profile/update', :to => 'profile#update'
  resources :news
  resources :posts
 # devise_for :users
  root to: "home#index"
  resources :profile, only: [:index, :update]
  devise_for :users, :controllers => { :registrations => "registrations" }
  #devise_for :users, :controllers => { :registrations => "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
