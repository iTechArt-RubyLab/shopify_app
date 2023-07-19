module ImportProducts

  def import_products_from_shopify
    Product.destroy_all
    products = ShopifyAPI::Product.all(session: @session)
    create_products(products)
  end

  private

  def create_products(shopify_products)
    shopify_products.each do |shopify_product|
      Product.create(
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
      # ProductVariant.create(
      #   barcode: shopify_product.barcode,
      #   compare_at_price: shopify_product.variants.compare_at_price,
      #   created_at: shopify_product.variants.created_at,
      #   fulfillment_service: shopify_product.variants.fulfillment_service,
      #   grams: shopify_product.variants.grams,
      #   weight: shopify_product.variants.weight,
      #   weight_unit: shopify_product.variants.weight_unit,
      #   id: shopify_product.variants.id,
      #   inventory_item_id: shopify_product.variants.inventory_item_id,
      #   inventory_management: shopify_product.variants.inventory_management,
      #   inventory_policy: shopify_product.variants.inventory_policy,
      #   inventory_quantity: shopify_product.variants.inventory_quantity,
      #   option1: shopify_product.variants.option1,
      #   position: shopify_product.variants.position,
      #   price: shopify_product.variants.price,
      #   product_id: shopify_product.variants.product_id,
      #   requires_shipping: shopify_product.variants.requires_shipping,
      #   sku: shopify_product.variants.sku,
      #   taxable: shopify_product.variants.taxable,
      #   title: shopify_product.variants.title,
      #   updated_at: shopify_product.variants.updated_at
      #
      #   )
      # ProductOption.create (
      #                        #     options: {
      #                        #       id: shopify_product.options.id,
      #                        #       product_id: shopify_product.options.product_id,
      #                        #       name: shopify_product.options.name,
      #                        #       position: shopify_product.options.position,
      #                        #       values: [
      #                        #         shopify_product.options.values
      #                        #       ]
      #                        #     },
      #                      )
    end
  end
end