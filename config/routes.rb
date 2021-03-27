Rails.application.routes.draw do

  get "restaurants/upvote", as: :upvote
  get "restaurants/downvote", as: :downvote
  #post 'search' => 'restaurants#search'
  #get 'search' => 'restaurants#search'
  #get "restaurants/search", as: :search
  post "restaurants/search", as: :search
  resources :restaurants, except: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
