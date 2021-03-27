Rails.application.routes.draw do

  get "restaurants/upvote", as: :upvote
  get "restaurants/downvote", as: :downvote

  resources :restaurants, except: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
