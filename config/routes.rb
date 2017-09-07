Rails.application.routes.draw do
  root "static_pages#index"
  resources :users, only: [:index, :new, :create, :show]

  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"
end
