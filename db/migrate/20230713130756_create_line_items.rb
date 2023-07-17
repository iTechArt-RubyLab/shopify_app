class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.integer :shopify_id
      t.integer :fulfillable_quantity
      t.string :fulfillment_service
      t.string :fulfillment_status
      t.boolean :gift_card
      t.integer :grams
      t.string :name
      t.decimal :price
      t.boolean :product_exists
      t.integer :product_id
      t.integer :quantity
      t.boolean :requires_shipping
      t.string :sku
      t.boolean :taxable
      t.string :title
      t.decimal :total_discount
      t.integer :variant_id
      t.string :variant_inventory_management
      t.string :variant_title
      t.string :vendor
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
