class ChangeShopifyIdToBigintInLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :line_items, :shopify_id, :bigint
  end
end
