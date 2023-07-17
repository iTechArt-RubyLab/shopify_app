class CreateMetafields < ActiveRecord::Migration[7.0]
  def change
    create_table :metafields do |t|
      t.integer :customer_id
      t.string :key
      t.string :namespace
      t.string :value
      t.string :value_type

      t.timestamps
    end
  end
end
