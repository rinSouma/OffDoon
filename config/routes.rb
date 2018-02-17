Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :home
  resources :login, only: [:create]
  resources :comment, only: [:create, :destroy]
  resources :member, only: [:create, :destroy]
  resources :myevent, only: [:index]
  resources :logout, only: [:index]

  root 'home#index'
  
  # Mastodon認証後
  get '/auth/:provider/callback', to: 'login#create'
end
