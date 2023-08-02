require 'rails_helper'

RSpec.describe AuthorizedController, type: :controller do
  controller do
    def index
      render plain: 'products'
    end
  end

  describe 'before_action :check_user_cookie_session' do
    context 'when shopify_app_session cookie is present' do
      it 'does not redirect' do
        cookies[:shopify_app_session] = 'spc'
        get :index
        expect(response).to_not redirect_to(login_path)
      end
    end

    context 'when shopify_app_session cookie is not present' do
      it 'redirects to login page' do
        cookies[:shopify_app_session] = nil
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
