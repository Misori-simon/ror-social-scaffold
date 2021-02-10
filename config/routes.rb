Rails.application.routes.draw do

  root 'posts#index'



  devise_for :users

  resources :users, only: [:index, :show]
  get "friendships/new_request/friend_id" => "friendships#new_request", as: "new_request"
  get "friendships/accept_request/friend_id" => "friendships#accept_request", as: "accept_request"
  get "friendships/decline_request/friend_id" => "friendships#decline_request", as: "decline_request"
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
