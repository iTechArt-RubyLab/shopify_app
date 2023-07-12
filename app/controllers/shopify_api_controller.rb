class ShopifyApiController < ApplicationController
  def products
    query = <<~GQL
      {
        products (first: 3) {
          edges {
            node {
              id
              title
            }
          }
        }
      }
    GQL
    session = ShopifyAPI::Auth::Session.new(
      shop: ENV['SHOP'],
      access_token: cookies[:shopify_app_session]
    )

    client = ShopifyAPI::Clients::Graphql::Admin.new(
      session:
    )

    @products = client.query(
      query:
    )
  end
end
