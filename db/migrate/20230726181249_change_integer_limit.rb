class ChangeIntegerLimit < ActiveRecord::Migration[7.0]
  def change
    change_column :customers, :shopify_id, :integer, limit: 8
    change_column :addresses, :customer_id, :integer, limit: 8
    change_column :email_marketing_consents, :customer_id, :integer, limit: 8
  end
end
