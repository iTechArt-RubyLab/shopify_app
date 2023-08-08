class CreateCanceledOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :canceled_orders do |t|
      t.integer :order_id, null: false

      t.timestamps
    end
  end
end
