class CreateProductImages < ActiveRecord::Migration[7.0]
  def change
    create_table :product_images do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :position
      t.integer :width
      t.integer :height
      t.string :src

      t.timestamps
    end
  end
end
