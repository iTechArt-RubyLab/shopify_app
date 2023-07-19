class ShopifyImportController < ShopifyApiController
  include ImportProducts
  def import
  import_products_from_shopify
  render plain: 'Data imported successfully'
  rescue => e
    render plain: "Error importing data: #{e.message}"
  end

end
