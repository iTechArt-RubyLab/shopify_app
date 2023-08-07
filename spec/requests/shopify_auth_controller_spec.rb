require 'rails_helper'

RSpec.describe ShopifyAuthController, type: :controller do
  describe '#login' do
    it 'redirects to the authentication route' do
      get :login
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(an_instance_of(String))
    end
  end

  describe '#callback' do
    context 'when authentication callback is successful' do
      it 'redirects to the root path' do
        get :callback, params: { controller: 'shopify_auth', action: 'callback' }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when authentication callback raises an error' do
      it 'logs the error and returns internal server error' do
        allow(ShopifyAPI::Auth::Oauth).to receive(:validate_auth_callback).and_raise(StandardError,
                                                                                     'Error')
        allow(Rails.logger).to receive(:debug)
        get :callback, params: { controller: 'shopify_auth', action: 'callback' }
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
