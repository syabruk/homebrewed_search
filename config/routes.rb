Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, only: %i[index create]
  resources :search, only: %i[index]
end
