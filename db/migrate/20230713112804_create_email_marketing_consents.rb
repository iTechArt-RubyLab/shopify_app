class CreateEmailMarketingConsents < ActiveRecord::Migration[7.0]
  def change
    create_table :email_marketing_consents do |t|
      t.integer :customer_id
      t.string :state
      t.string :opt_in_level
      t.datetime :consent_updated_at

      t.timestamps
    end
  end
end
