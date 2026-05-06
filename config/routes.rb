Rails.application.routes.draw do
  resources :registrations, only: %i[new create]
  resource :session
  resources :passwords, param: :token
  resources :ordenes_caoticas, only: [:index]

  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
