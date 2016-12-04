Rails.application.routes.draw do
  get 'authen_accept/accept'
  post 'photos/add-favorite', :to => 'photos#addFavorite'

  resources :galleries 
  get '/o/oauth2/auth', :to => 'authen_accept#accept'
  post 'home/update_gallery', :to => 'home#update_gallery'
  post 'galleries/update', :to => 'galleries#update'
  post 'galleries/add-favorite', :to => 'galleries#addFavorite'
  post 'galleries/add-photo', :to => 'galleries#addPhoto'
  # get 'profile/index'
  get 'profile/:id', :to => "profile#getUser"
  get 'profile/events_one', :to => "profile#events_one"
  post 'profile/update', :to => 'profile#update'
  post 'members/update', :to => 'members#update'
  post 'members/update_hours', :to => 'members#update_hours'
  post 'members/delete', :to => 'members#delete'
  post 'home/update', :to => 'home#update'
  get 'members/show', :to => 'members#show'
  resources :news
  resources :posts
 # devise_for :users
  root to: "home#index"
  resources :calendar, only: [:index]
  resources :about, only: [:index]
  resources :home, only: [:index, :update]
  resources :profile, only: [:index, :update]
  resources :members, only: [:index]
  devise_for :users, :controllers => { :registrations => "registrations" }
  #devise_for :users, :controllers => { :registrations => "registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :photos, only: [:index, :show, :new, :create, :destroy]
  root 'photos#index'
end
