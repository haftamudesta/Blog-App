Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index, :show, :new, :create, :destroy] do
          resources :comments, only: [:index, :new, :create, :destroy]
          resources :likes, only: [:create]
        end
      end
    end
  end
end
