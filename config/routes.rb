Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get "/auth/:provider/callback", to: "sessions#create", as: 'auth_callback'
  get '/dashboard', to: "users#dashboard", as: 'dashboard'
  get '/pages/contact_us', to: 'pages#contact_us', as: 'contact_us'
  delete "/logout", to: "sessions#destroy", as: "logout"
  get '/shopping_cart', to: 'orders#shopping_cart', as: 'shopping_cart'
  patch '/shopping_cart', to: 'order_products#update', as: 'order_product'
  get '/checkout', to: 'orders#edit', as: 'checkout'
  post '/checkout', to: 'orders#update'

  get '/account', to: 'users#show', as: 'account'
  patch '/product/:id', to: 'products#deactivate', as: 'deactivate_product'
  patch '/users/:id', to: 'users#update', as: 'update_user'
  get '/merchant/orders', to: 'users#orders_index', as: 'merchant_orders'
  get '/merchant/orders/:id', to: 'users#order_show', as: 'merchant_order'
  get '/products_by_merchant', to: 'products#index_by_merchant', as: 'index_by_merchant'




  resources :products
  resources :users, only: [:create, :show] #do
  #   resources :products, only: [:show, :edit]
  # end
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
