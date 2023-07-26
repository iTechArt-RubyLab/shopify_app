Rails.application.routes.draw do
  root 'shopify_api#products'
  get '/login', to: 'shopify_auth#login'
  get '/auth/callback', to: 'shopify_auth#callback'
  post '/webhooks/shopify/product_updated', to: 'webhooks#product_updated'
  resources :orders, only: [:index, :show]
  resources :products
end
