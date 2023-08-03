class ChangeIntegerLimits < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :shopify_id, :integer, limit: 8
  end
end
