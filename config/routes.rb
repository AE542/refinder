Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :items
  get 'my_items', to: 'items#my_items', as: 'my_items'
  # Defines the root path route ("/")
  # root "articles#index"

  resources :chatrooms, only: [:show, :index] do
    resources :messages, only: [:create], param: :chatroom_id
  end
end
