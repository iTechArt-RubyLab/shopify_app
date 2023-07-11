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
    session: session
  )

  @products = client.query(
    query: query
  )
  end
end
