Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  resources :books, only: [ :new, :create, :show, :index, :edit, :update, :destroy ]
  resources :users, only: [ :show,:index, :edit, :update ]

end
