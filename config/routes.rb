Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get "/auth/:provider/callback", to: "sessions#create"
  get '/pages/contact_us', to: 'pages#contact_us', as: 'contact_us'

  get '/shopping_cart', to: 'orders#shopping_cart', as: 'shopping_cart'



  resources :products
  resources :users
  resources :addresses
  resources :payments
  resources :reviews
  resources :orders

  resources :order_products, only: [:create]
  # resources :orders do
  #   resources :products, only: [:create]
  # end
end
