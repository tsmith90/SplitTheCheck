Rails.application.routes.draw do
  resources :comments
  resources :favorites
  resources :votes
  devise_for :users
  root 'restaurants#index'
  get "restaurants/upvote", as: :upvote
  get "restaurants/downvote", as: :downvote
  #post 'search' => 'restaurants#search'
  #get 'search' => 'restaurants#search'
  #get "restaurants/search", as: :search
  post "restaurants/search", as: :search
  get "users/summary", as: :summary
  post "users/summary"
  resources :restaurants, except: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
