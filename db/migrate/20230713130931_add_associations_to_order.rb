class AddAssociationsToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :line_items, null: false, foreign_key: true
  end
end
