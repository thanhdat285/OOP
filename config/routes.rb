Rails.application.routes.draw do
  root "static_pages#index"
  resources :users, only: [:index, :new, :create, :show]

  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :customers do
        resources :films, only: :index
        resources :locations, only: :index
        resources :rooms, only: :index
        resources :tickets, only: :index

        post :sign_up, to: "users#create"
        post :sign_in, to: "sessions#create"
        delete :sign_out, to: "sessions#destroy"
      end
    end
  end
end
