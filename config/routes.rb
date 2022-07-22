Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'cards#index'
  resources :cards, only: %i[index show]
  resources :cards, except: %i[index show], path: :author
  get '/author', to: 'cards#author_index', as: 'author_index'
end
