class AddReferencesToCustomerTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :address, null: false, foreign_key: true
    add_reference :customers, :email_marketing_consent, null: false, foreign_key: true
  end
end
