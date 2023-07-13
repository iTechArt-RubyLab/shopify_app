class CreateProductVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :barcode
      t.string :compare_at_price
      t.string :fulfillment_service
      t.integer :grams
      t.decimal :weight
      t.string :weight_unit
      t.integer :inventory_item_id
      t.string :inventory_management
      t.string :inventory_policy
      t.integer :inventory_quantity
      t.string :option1
      t.decimal :price
      t.boolean :requires_shipping
      t.string :sku
      t.boolean :taxable
      t.integer :position
      t.string :title

      t.timestamps
    end
  end
end
