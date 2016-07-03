Rails.application.routes.draw do
  root 'application#index'

  resources :users
  resources :sessions
  resources :decks do
    resources :cards
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
      resources :decks do
        resources :cards
      end
      get 'study' => 'decks#study'
    end
  end

  namespace :benkyo do
    resources :users
    resources :sessions
  end

  get    '/login'      => 'sessions#new'
  delete '/logout'     => 'sessions#destroy'
  post   '/study/:id'  => 'decks#study'
end
