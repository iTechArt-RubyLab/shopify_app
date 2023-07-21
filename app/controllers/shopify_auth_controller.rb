class ShopifyAuthController < ApplicationController
  def login
    auth_response = ShopifyAPI::Auth::Oauth.begin_auth(shop: ENV['SHOP'], redirect_path: '/auth/callback')

    cookies[auth_response[:cookie].name] = {
      expires: auth_response[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_response[:cookie].value
    }

    head :temporary_redirect
    response.set_header('Location', auth_response[:auth_route])
  end

  def callback
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query: ShopifyAPI::Auth::Oauth::AuthQuery.new(**request.parameters.symbolize_keys.except(:controller,
                                                                                                    :action))
    )

    cookies[auth_result[:cookie].name] = {
      expires: auth_result[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_result[:session].access_token
    }
    cookies[:shopify_user_id] = auth_result[:session].associated_user&.id
  
    head :temporary_redirect
    response.set_header('Location', root_path)
  rescue StandardError => e
    Rails.logger.debug(e.message)
    head :internal_server_error
  end
end
