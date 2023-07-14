class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :value
      t.references :line_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
