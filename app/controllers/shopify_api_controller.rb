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
  session = ShopifyAPI::Utils::SessionUtils.load_current_session(
    auth_header: cookies[:shopify_app_session],
    cookies: cookies,
    is_online: true
  )

  client = ShopifyAPI::Clients::Graphql::Admin.new(
    session: session
  )

  products = client.query(
    query: query
  )
  end
end
