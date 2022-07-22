Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'cards#index'
  resources :cards, param: :slug
  get '/author', to: 'cards#author_index', as: 'author_index'
  get '/author/:slug', to: 'cards#author_show', as: 'author_card'
end
