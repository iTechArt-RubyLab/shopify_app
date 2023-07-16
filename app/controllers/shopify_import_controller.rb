class ShopifyImportController < ShopifyApiController
  def import
    shopify_products = fetch_shopify_products
    import_products(shopify_products)
    render plain: 'Data imported successfully'
  rescue => e
    render plain: "Error importing data: #{e.message}"
  end

  private

  def fetch_shopify_products
    @products = ShopifyAPI::Product.all(session: @session)
  end

  def import_products(shopify_products)
    shopify_products.each do |shopify_product|
        Product.create(
          title: shopify_product.title,
          shopify_id: shopify_product.id,
          body_html: shopify_product.body_html,
          handle: shopify_product.handle,
          product_type: shopify_product.product_type,
          published_at: shopify_product.published_at,
          published_scope: shopify_product.published_scope,
          status: shopify_product.status,
          tags: shopify_product.tags,
          template_suffix: shopify_product.template_suffix,
          vendor: shopify_product.vendor
        )
      end
  end
end
