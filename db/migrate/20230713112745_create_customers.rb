class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.integer :shopify_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.datetime :created_at
      t.datetime :updated_at
      t.boolean :accepts_marketing
      t.datetime :accepts_marketing_updated_at
      t.string :tags
      t.boolean :verified_email
      t.string :state
      t.integer :last_order_id
      t.string :last_order_name
      t.integer :orders_count
      t.string :total_spent
      t.boolean :tax_exempt
      t.string :multipass_identifier
      t.string :note


      t.timestamps
    end
  end
end
