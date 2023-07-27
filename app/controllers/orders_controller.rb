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

  def edit
    @line_items = @order.line_items
  end

  def create
    @shopify_order = ShopifyAPI::Order.new(session: @session)
    @local_order = Order.create(order_params)

    assign_order_attributes

    if @shopify_order.save!
      @local_order.shopify_id = @shopify_order.id
      @local_order.name = @shopify_order.name
      @local_order.total_price = @shopify_order.total_price

      @local_order.save!
      redirect_to orders_path, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    assign_order_attributes
    if @shopify_order.save! && @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end


  def cancel
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    if @shopify_order.cancel
      CanceledOrder.create(order: @order)
      redirect_to @order, notice: 'Заказ успешно отменен.'
    else
      redirect_to @order, alert: 'Ошибка при отмене заказа.'
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
      line_item = LineItem.new(
        title: Product.find_by(id: product_id).title,
        product_id: product_id,
        quantity: product_quantities[index],
        order_id: @local_order.id,
        grams: "1300",
        price: 51.00,

      )
      line_item.save!
      @shopify_order.line_items << line_item
    end
  end

  def create_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end
end
