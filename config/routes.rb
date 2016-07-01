Rails.application.routes.draw do
  root to: 'storage#index'

  resources :storage, only: %i[index create]
  resources :search, only: %i[index]
end
