class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :shopify_id
      t.string :name
      t.decimal :total_price

      t.timestamps
    end
  end
end
