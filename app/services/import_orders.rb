class ImportOrders
  def initialize(session)
    @session = session
  end

  def call
    Order.destroy_all
    orders = ShopifyAPI::Order.all(session: @session)
    create_orders(orders)
  end

  private

  def create_orders(shopify_orders)
    shopify_orders.each do |shopify_order|
      ActiveRecord::Base.transaction do
        order = Order.create!(
          shopify_id: shopify_order.id,
          name: shopify_order.name,
          total_price: shopify_order.total_price,
          updated_at: shopify_order.updated_at
        )

        line_item = order.line_items.create!(
          shopify_id: shopify_order.line_items.first['id'],
          fulfillable_quantity: shopify_order.line_items.first['fulfillable_quantity'],
          fulfillment_service: shopify_order.line_items.first['fulfillment_service'],
          fulfillment_status: shopify_order.line_items.first['fulfillment_status'],
          gift_card: shopify_order.line_items.first['gift_card'],
          grams: shopify_order.line_items.first['grams'],
          name: shopify_order.line_items.first['name'],
          price: shopify_order.line_items.first['price'],
          product_exists: shopify_order.line_items.first['product_exists'],
          product_id: shopify_order.line_items.first['product_id'],
          quantity: shopify_order.line_items.first['quantity'],
          requires_shipping: shopify_order.line_items.first['requires_shipping'],
          sku: shopify_order.line_items.first['sku'],
          taxable: shopify_order.line_items.first['taxable'],
          title: shopify_order.line_items.first['title'],
          total_discount: shopify_order.line_items.first['total_discount'],
          variant_id: shopify_order.line_items.first['variant_id'],
          variant_inventory_management: shopify_order.line_items.first['variant_inventory_management'],
          variant_title: shopify_order.line_items.first['variant_title'],
          vendor: shopify_order.line_items.first['vendor']
        )

        line_item.create_price_set!(
          shop_money: shopify_order.line_items.first['price_set']['shop_money'],
          presentment_money: shopify_order.line_items.first['price_set']['presentment_money']
        )
      end
    end
  end
end
