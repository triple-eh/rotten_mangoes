Rails.application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :show] 
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'

  namespace :admin do
    resources :users
    resource :session, only: [:destroy], controller: :sessions do 
      collection do 
        post 'become'
      end
    end
  end

end
