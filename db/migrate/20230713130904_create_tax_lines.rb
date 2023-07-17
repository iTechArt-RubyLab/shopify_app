class CreateTaxLines < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_lines do |t|
      t.boolean :channel_liable
      t.decimal :price
      t.decimal :rate
      t.string :title
      t.references :line_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
