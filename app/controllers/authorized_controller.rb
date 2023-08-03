class AuthorizedController < ApplicationController
  before_action :check_user_cookie_session

  def check_user_cookie_session
    redirect_to login_path if cookies[:shopify_app_session].blank?
  end
end
