Rails.application.routes.draw do
  root 'shopify_api#products'
  get '/login', to: 'shopify_auth#login'
  get '/auth/callback', to: 'shopify_auth#callback'
  resources :orders, only: [:index, :show, :create, :update] do
    member do
      put :cancel # Для отмены заказа
    end
  end
end
