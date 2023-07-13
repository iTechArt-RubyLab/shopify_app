class CreateDiscountAllocations < ActiveRecord::Migration[7.0]
  def change
    create_table :discount_allocations do |t|
      t.decimal :amount
      t.integer :discount_application_index
      t.references :line_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
