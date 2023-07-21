class CartsController < ApplicationController
  def index
    storefront_client = ShopifyAPI::Clients::Graphql::Storefront.new(ENV['SHOP'], ENV['STOREFRONT_ACCESS_TOKEN'])
    query = <<~GQL
    mutation {
      customerCreate(input: 
        {
          acceptsMarketing: true,
          email: "abc@yahoo.com",
          firstName: "Prosto",
          lastName: "Pzdc",
          password: "12345678",
          phone: "+375298464577"
        }) {
        customer {
          id
          firstName
          lastName
          email
          phone
        }
        customerUserErrors {
          field
          message
          code
        }
      }
    }
  GQL
    products = storefront_client.query(query:)
    render json: products.body
  end

  private

  def shopify_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end
end
