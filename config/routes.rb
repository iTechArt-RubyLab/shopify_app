Rails.application.routes.draw do
  root 'shopify_api#products'
  get '/login', to: 'shopify_auth#login'
  get '/auth/callback', to: 'shopify_auth#callback'
  resources :orders, only: [:index]
  # we need post request here
  get '/import_shopify_data', to: 'shopify_import#import'
end
