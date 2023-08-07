class WebhooksCustomerController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:customer_updated]

  def customer_updated
    data = JSON.parse(request.body.read)
    customer_id = data['id']

    @customer = Customer.find_by(shopify_id: customer_id)
    if @customer.present?
      assign_customer_attributes(data)
      if @customer.save!
        redirect_to @customer, notice: 'updated.'
      else
        redirect_to @customer, notice: 'Could not update'
      end
    else
      redirect_to customers_path, alert: 'error. Not found'
    end
  end

  private

  def assign_customer_attributes(data)
    @customer.assign_attributes(
      email: data['email'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      accepts_marketing: data['accepts_marketing'],
      created_at: data['created_at'],
      verified_email: data['verified_email'],
      status: data['status'],
      tags: data['tags']
    )


  end


end
