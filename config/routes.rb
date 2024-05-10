Rails.application.routes.draw do
  root "nba#index"

  resources :nba, only: [:index]
end