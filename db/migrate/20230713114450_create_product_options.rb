class CreateProductOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :product_options do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
