class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:product_updated]
  
  def product_updated
    data = JSON.parse(request.body.read)
    product_id = data['id']

    @shopify_product = ShopifyAPI::Product.find(session: @session, id: @product.shopify_id)
    @product = Product.find_by(shopify_id: product_id)
    if @product
      assign_product_attributes(data)
      if @product.save! && @shopify_product.save!
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        redirect_to @product, notice: 'Could not update the product.'
      end
    else
      redirect_to products_path, alert: 'Could not find the product in local database.'
    end
  end
  
  private
  
  def assign_product_attributes(data)
    @product.title = data['title']
    @product.body_html = data['body_html']
    @product.status = data['status']
    @product.vendor = data['vendor']
  end
end
