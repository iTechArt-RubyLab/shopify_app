class RemoveLineItemsIdFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :line_items_id, :integer
  end
end
