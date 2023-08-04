class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy cancel]
  before_action :create_session, only: %i[create update destroy cancel]

  def index
    @orders = Order.all
  end

  def show ;end

  def new
    @order = Order.new
  end

  def create
    @shopify_order = ShopifyAPI::Order.new(session: @session)
    @order = Order.new(order_params)

    assign_order_attributes

    if @shopify_order.save!
      @order.shopify_id = @shopify_order.id
      @order.name = @shopify_order.name
      @order.total_price = @shopify_order.total_price

      @shopify_order.line_items.each do  |line_item|

        params = line_item.except("id", "admin_graphql_api_id","properties", "tax_lines", "price_set", "duties", "discount_allocations", "total_discount_set" )
        params["shopify_id"] = line_item["id"]


        order_line_item =  @order.line_items.new(params)
        order_line_item.price_set = PriceSet.new(line_item["price_set"])
        #order_line_item.duties.new(line_item["duties"])
        #order_line_item.discount_allocations.new(line_item["discount_allocations"])
        #order_line_item.total_discount_set.new(line_item["total_discount_set"])

        order_line_item.save
      end
      @order.save!
      redirect_to orders_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    if @shopify_order.cancel
      CanceledOrder.create(order: @order)
      redirect_to orders_path
    else
      redirect_to @order, alert: 'Error while canceling the order'
    end
  end


  def destroy
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    if @order.destroy && @shopify_order.delete
      redirect_to orders_path, notice: 'The Order was successfully destroyed.'
    end

  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :total_price)
  end

  def assign_order_attributes
    product_ids = params[:order][:product_ids].reject(&:empty?)
    product_quantities = params[:order][:product_quantities].map(&:to_i)
    @shopify_order.line_items = []

    product_ids.each_with_index do |product_id, index|
      @shopify_order.line_items << {  title: Product.find_by(id: product_id).title,
                                      product_id: Product.find_by(id: product_id).shopify_id,
                                      quantity: product_quantities[index],
                                      grams: "1300",
                                      price: 51.00}
    end
  end

  def create_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end

end

