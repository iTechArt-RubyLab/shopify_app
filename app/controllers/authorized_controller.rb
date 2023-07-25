class AuthorizedController < ApplicationController
  before_action :check_user_cookie_session

  def check_user_cookie_session
    redirect_to login_path unless cookies[:shopify_app_session].present?
  end
end