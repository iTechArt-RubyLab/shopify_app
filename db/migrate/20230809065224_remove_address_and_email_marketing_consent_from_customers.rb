class RemoveAddressAndEmailMarketingConsentFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :address_id
    remove_column :customers, :email_marketing_consent_id
  end
end
