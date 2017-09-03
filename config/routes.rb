Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
    member do
      get :want_to_gos
      get :wents
    end
  end
  
  resources :restaurants, only: [:new]
  resources :visits, only: [:create, :destroy]
end
