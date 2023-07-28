class ImportCustomers
  def initialize(session)
    @session = session
  end

  def call
    Address.destroy_all
    EmailMarketingConsent.destroy_all
    customers = ShopifyAPI::Customer.all(session: @session)
    create_customers(customers)
  end

  private

  def create_customers(shopify_customers)
    shopify_customers.each do |shopify_customer|
      ActiveRecord::Base.transaction do
        address = Address.create!(
          id: shopify_customer.addresses.first['id'],
          customer_id: shopify_customer.addresses.first['customer_id'],
          first_name: shopify_customer.addresses.first['first_name'],
          last_name: shopify_customer.addresses.first['last_name'],
          company: shopify_customer.addresses.first['company'],
          address1: shopify_customer.addresses.first['address1'],
          address2: shopify_customer.addresses.first['address2'],
          city: shopify_customer.addresses.first['city'],
          province: shopify_customer.addresses.first['province'],
          country: shopify_customer.addresses.first['country'],
          zip: shopify_customer.addresses.first['zip'],
          phone: shopify_customer.addresses.first['phone'],
          province_code: shopify_customer.addresses.first['province_code'],
          country_code: shopify_customer.addresses.first['country_code'],
          country_name: shopify_customer.addresses.first['country_name'],
          is_default: shopify_customer.addresses.first['default']
        )
        emc = EmailMarketingConsent.create!(
          customer_id: shopify_customer.id,
          state: shopify_customer.email_marketing_consent['state'],
          opt_in_level: shopify_customer.email_marketing_consent['opt_in_level'],
          consent_updated_at: shopify_customer.email_marketing_consent['consent_updated_at']
        )
        address.customers.create(
          created_at: shopify_customer.created_at,
          email: shopify_customer.email,
          first_name: shopify_customer.first_name,
          last_name: shopify_customer.last_name,
          shopify_id: shopify_customer.id,
          last_order_id: shopify_customer.last_order_id,
          last_order_name: shopify_customer.last_order_name,
          multipass_identifier: shopify_customer.multipass_identifier,
          note: shopify_customer.note,
          orders_count: shopify_customer.orders_count,
          state: shopify_customer.state,
          tags: shopify_customer.tags,
          tax_exempt: shopify_customer.tax_exempt,
          total_spent: shopify_customer.total_spent,
          updated_at: shopify_customer.updated_at,
          verified_email: shopify_customer.verified_email,
          email_marketing_consent_id: emc.id
        )
      end
    end
  end
end
