Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get "/auth/:provider/callback", to: "sessions#create", as: 'auth_callback'

  get '/pages/contact_us', to: 'pages#contact_us', as: 'contact_us'
  delete "/logout", to: "sessions#destroy", as: "logout"
  get '/shopping_cart', to: 'orders#shopping_cart', as: 'shopping_cart'
  patch '/shopping_cart', to: 'order_products#update', as: 'order_product'
  get '/checkout', to: 'orders#edit', as: 'checkout'
  post '/checkout', to: 'orders#update'
  get '/account', to: 'users#show', as: 'account'

  resources :products
  resources :users, only: [:create, :show]
  resources :addresses
  resources :payments
  resources :reviews
  resources :orders
  resources :sessions, only: [:create, :destroy]
  resources :order_products, only: [:create]
  # resources :orders do
  #   resources :products, only: [:create]
  # end
end
