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

  def edit; end

  def create
    @shopify_order = ShopifyAPI::Order.new(session: @session)
    assign_order_attributes
    @local_order = Order.new(order_params)

    if @shopify_order.save!
      @local_order.shopify_id = @shopify_order.id
      @local_order.name = @shopify_order.name
      #TODO :  @local_order.line_items = @shopify_order.line_items
      @local_order.save!
      redirect_to orders_path, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    assign_order_attributes
    @shopify_order.transactions = [
      {
        "kind" => "sale",
        "status" => "success",
        "amount" => 111.22
      }
    ]
    if @shopify_order.save! && @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end


  def cancel
    @shopify_order = ShopifyAPI::Order.find(session: @session, id: @order.shopify_id)
    if @shopify_order.cancel
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
        order_id: @shopify_order.id,
        grams: "1300",
        price: 50.00,

      )
      line_item.save


      @shopify_order.line_items << line_item
      end
=begin
      @shopify_order.transactions = [
        {
          "kind" => "sale",
          "status" => "success",
          "amount" => 238.47
        }
      ]
      @shopify_order.total_tax = 13.5
      @shopify_order.currency = "EUR"
      end
=end
=begin
    @shopify_order.line_items = [
      {
        "title" => "Big Brown Bear Boots",
        "price" => 60.00,
        "grams" => "1300",
        "quantity" => 3,
        "tax_lines" => [
          {
            "price" => 13.5,
            "rate" => 0.06,
            "title" => "State tax"
          }
        ]
      }
    ]
=end
  end

  def create_session
    @session = ShopifyAPI::Auth::Session.new(shop: ENV['SHOP'], access_token: cookies[:shopify_app_session])
  end
end
