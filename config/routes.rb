Rails.application.routes.draw do
  root "static_pages#index"
  resources :users, only: [:index, :new, :create, :show]

  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :films, only: [:index, :show, :create]
      resources :locations, only: :index
      resources :rooms, only: :index
      resources :tickets, only: [] do 
        put :book, on: :collection
        get :history_book, on: :collection 
        get :history_users_book, on: :collection
      end
      resources :schedules, only: [:index, :show, :create]
      resources :users, only: [:update] do 
        put :deposit, on: :collection
        put :update_password, on: :collection
      end

      post :sign_in, to: "sessions#create"
      delete :sign_out, to: "sessions#destroy"

      namespace :customers do
        resources :films, only: [:index, :show, :create]
        resources :locations, only: :index
        resources :rooms, only: :index
        resources :tickets, only: [] do 
          put :book, on: :collection
          get :history_book, on: :collection 
          get :history_users_book, on: :collection
        end
        resources :schedules, only: [:index, :show, :create]
        resources :users, only: [:update] do 
          put :deposit, on: :collection
          put :update_password, on: :collection
        end

        post :sign_in, to: "sessions#create"
        delete :sign_out, to: "sessions#destroy"
      end
      post :sign_up, to: "users#create"
    end
  end
end
