class ShopifyApiController < ApplicationController
  def products
    storefront_access_token = ENV['STOREFRONT_ACCESS_TOKEN']
    shop = ENV['SHOP']
    storefront_client = ShopifyAPI::Clients::Graphql::Storefront.new(
      shop,
      storefront_access_token
    )
    my_query = <<~QUERY
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
    QUERY
    @products = storefront_client.query(query: my_query)
  end
end
