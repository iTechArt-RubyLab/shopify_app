class ShopifyImportController < ShopifyApiController
  def import
    ImportProducts.new(@session).call
    ImportCustomers.new(@session).call
    ImportOrders.new(@session).call
    render plain: 'Data imported successfully'
  rescue StandardError => e
    render plain: "Error importing data: #{e.message}"
  end
end
