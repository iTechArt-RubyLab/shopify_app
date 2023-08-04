class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update]
  before_action :create_session, only: %i[create update destroy]

  def index
    @customers = Customer.all
  end

  def show; end

  def new
    @customer = Customers.new
  end

  def edit; end

  def create
    @shopify_customer = ShopifyAPI::Customer.new(session: @session)
    assign_customer_attributes(customer_params)
    @local_customer = Customer.new(customer_params)

    if @shopify_customer.save!
      @local_customer.shopify_id = @shopify_customer.id
      @local_customer.save!
      redirect_to customers_path, notice: 'created.'
    else
      redirect_to customers_path, alert: 'Error while creating the customer'
    end
  end

  def update
    @shopify_customer = ShopifyAPI::Customer.find(session: @session, id: @customer.shopify_id)
    assign_customer_attributes(customer_params)
    if @shopify_customer.save! && @customer.update(customer_params)
      redirect_to @customer, notice: 'updated.'
    else
      redirect_to customers_path, alert: 'Error while updating the customer'
    end
  end



  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:email, :body_html, :status, :vendor)
  end

  def assign_customer_attributes(customer_params)
    @shopify_customer.email = customer_params[:email]
    @shopify_customer.body_html = customer_params[:body_html]
    @shopify_customer.status = customer_params[:status]
    @shopify_customer.vendor = customer_params[:vendor]
  end

  def create_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end
end