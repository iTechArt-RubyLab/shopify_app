class ShopifyApiController < AuthorizedController
  before_action :authenticate_shopify_session

  def products
    query = <<~GQL
      {
        products(first: 3) {
          edges {
            node {
              id
              title
            }
          }
        }
      }
    GQL

    @products = @shopify_client.query(query:)
    render json: @products.body
  end

  private

  def authenticate_shopify_session
    session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
    @shopify_client = ShopifyAPI::Clients::Graphql::Admin.new(session:)
  end
end
