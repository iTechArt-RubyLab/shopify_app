class CreateProductOptionValues < ActiveRecord::Migration[7.0]
  def change
    create_table :product_option_values do |t|
      t.references :product_option, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
