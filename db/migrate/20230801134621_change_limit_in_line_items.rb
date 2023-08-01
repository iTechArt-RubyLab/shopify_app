class ChangeLimitInLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :line_items, :shopify_id, :integer, limit: 8
  end
end
