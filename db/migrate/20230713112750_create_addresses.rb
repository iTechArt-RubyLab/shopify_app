class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :customer_id
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :country
      t.string :zip
      t.string :phone
      t.string :province_code
      t.string :country_code
      t.string :country_name
      t.boolean :is_default

      t.timestamps
    end
  end
end
