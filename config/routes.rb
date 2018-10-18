Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/pages/about_us', to: 'pages#show', as: 'about_us'
  resources :products
  resources :user
  resources :address
  resources :payments
  resources :reviews
  resources :orders
end
