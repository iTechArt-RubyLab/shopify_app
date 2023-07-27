class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:product_updated]
  
  def product_updated
    data = JSON.parse(request.body.read)
    product_id = data['id']

    @product = Product.find_by(shopify_id: product_id)
    if @product
      assign_product_attributes(data)
      if @product.save!
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
    @product.vendor = data['vendor']
    @product.product_type = data['product_type']
    @product.created_at = data['created_at']
    @product.handle = data['handle']
    @product.updated_at = data['updated_at']
    @product.published_at = data['published_at']
    @product.template_suffix = data['template_suffix']
    @product.status = data['status']
    @product.published_scope = data['published_scope']
    @product.tags = data['tags']
  
    existing_variant_ids = @product.product_variants.pluck(:id)
  
    data['variants'].each do |variant_data|
      variant_id = variant_data['id']
      
      unless existing_variant_ids.include?(variant_id)
        @variant = @product.product_variants.new
        @variant.id = variant_id
        @variant.price = variant_data['price']
        @variant.sku = variant_data['sku']
        @variant.inventory_policy = variant_data['inventory_policy']
        @variant.save!
      end
    end
  end
end
