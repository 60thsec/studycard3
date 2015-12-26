Rails.application.routes.draw do
  root 'application#index'

  resources :users
  resources :sessions
  resources :decks do
    resources :cards
  end

  get    '/login'  => 'sessions#new'
  delete '/logout' => 'sessions#destroy'
  post   '/study/:id'  => 'decks#study'

end
