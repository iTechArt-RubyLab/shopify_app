module ImportProducts
  def import_products_from_shopify
    Product.destroy_all
    products = ShopifyAPI::Product.all(session: @session)
    create_products(products)
  end

  private

  def create_products(shopify_products)
    shopify_products.each do |shopify_product|
      ActiveRecord::Base.transaction do
        product = Product.create!(
          body_html: shopify_product.body_html,
          created_at: shopify_product.created_at,
          handle: shopify_product.handle,
          shopify_id: shopify_product.id,
          product_type: shopify_product.product_type,
          published_at: shopify_product.published_at,
          published_scope: shopify_product.published_scope,
          status: shopify_product.status,
          tags: shopify_product.tags,
          template_suffix: shopify_product.template_suffix,
          title: shopify_product.title,
          updated_at: shopify_product.update_at,
          vendor: shopify_product.vendor
        )
        product.product_options.create([
          id: shopify_product.options.first['id'],
          product_id: shopify_product.options.first['product_id'],
          name: shopify_product.options.first['name'],
          position: shopify_product.options.first['position']
                                      ])
        product.product_variants.create([
          barcode: shopify_product.barcode,
          compare_at_price: shopify_product.compare_at_price,
          created_at: shopify_product.created_at,
          fulfillment_service: shopify_product.fulfillment_service,
          grams: shopify_product.grams,
          weight: shopify_product.weight,
          weight_unit: shopify_product.weight_unit,
          id: shopify_product.id,
          inventory_item_id: shopify_product.inventory_item_id,
          inventory_management: shopify_product.inventory_management,
          inventory_policy: shopify_product.inventory_policy,
          inventory_quantity: shopify_product.inventory_quantity,
          option1: shopify_product.option1,
          position: shopify_product.position,
          price: shopify_product.price,
          product_id: shopify_product.product_id,
          requires_shipping: shopify_product.requires_shipping,
          sku: shopify_product.sku,
          taxable: shopify_product.taxable,
          title: shopify_product.title,
          updated_at: shopify_product.updated_at
                                       ] )
      end
    end
  end
end
