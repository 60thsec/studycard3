Rails.application.routes.draw do
  root 'application#index'

  resources :users
  resources :sessions
  resources :decks

  get    '/login'  => 'sessions#new'
  delete '/logout' => 'sessions#destroy'


end
