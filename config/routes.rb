Rails.application.routes.draw do
  root 'shopify_api#products'
  get '/login', to: 'shopify_auth#login'
  get '/auth/callback', to: 'shopify_auth#callback'
  get '/import_shopify_data', to: 'shopify_import#import'
  post '/webhooks/shopify/product_updated', to: 'webhooks#product_updated'
  post '/webhooks/shopify/order_cancelled', to: 'webhooks#order_cancelled'
  post '/webhooks/shopify/order_updated', to: 'webhooks#order_updated'
  resources :orders do
    member do
      post :cancel
    end
  end
  resources :products
end
