class CreateSmsMarketingConsents < ActiveRecord::Migration[7.0]
  def change
    create_table :sms_marketing_consents do |t|
      t.integer :customer_id
      t.string :state
      t.string :opt_in_level
      t.datetime :consent_updated_at
      t.string :consent_collected_from

      t.timestamps
    end
  end
end
