class CreatePriceSets < ActiveRecord::Migration[7.0]
  def change
    create_table :price_sets do |t|
      t.json :shop_money
      t.json :presentment_money
      t.references :line_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
