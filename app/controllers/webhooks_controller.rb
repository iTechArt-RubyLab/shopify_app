class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:product_updated]

  def product_updated
    data = JSON.parse(request.body.read)
    product_id = data['id']

    @product = Product.find_by(shopify_id: product_id)
    if @product.present?
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
    @product.assign_attributes(
      title: data['title'],
      body_html: data['body_html'],
      vendor: data['vendor'],
      product_type: data['product_type'],
      created_at: data['created_at'],
      handle: data['handle'],
      updated_at: data['updated_at'],
      published_at: data['published_at'],
      template_suffix: data['template_suffix'],
      status: data['status'],
      published_scope: data['published_scope'],
      tags: data['tags']
    )

    @product.product_variants.pluck(:id)

    variant_attributes = data['variants'].map do |variant_data|
      variant_id = variant_data['id']

      {
        id: variant_id,
        product_id: @product.id,
        price: variant_data['price'],
        sku: variant_data['sku'],
        inventory_policy: variant_data['inventory_policy']
      }
    end

    @product.product_variants.upsert_all(variant_attributes, unique_by: :id)
  end
end
