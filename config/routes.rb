Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  get '/shopping_cart', to: 'orders#shopping_cart', as: 'shopping_cart'
  resources :products
  resources :user
  resources :address
  resources :payments
  resources :reviews
  resources :orders
end
