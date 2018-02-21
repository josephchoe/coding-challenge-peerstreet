Rails.application.routes.draw do
  resources :census, only: [:index]
end
