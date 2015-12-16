Rails.application.routes.draw do
  root 'application#index'

  resources :users
  resources :sessions

  delete '/logout' => 'sessions#destroy'

end
