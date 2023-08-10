class ChangeShopifyIdToBigintInOrders < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :shopify_id, :bigint
  end
end
