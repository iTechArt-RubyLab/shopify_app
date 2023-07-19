Rails.application.routes.draw do
  root 'shopify_api#products'
  get '/login', to: 'shopify_auth#login'
  get '/auth/callback', to: 'shopify_auth#callback'
  resources :products, only: [:index, :show]
  resources :orders
end
