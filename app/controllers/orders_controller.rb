class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      # Если заказ успешно создан, выполните необходимые действия
      # например, отправка данных в Shopify или обновление статуса заказа
      redirect_to @order, notice: 'Заказ успешно создан.'
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      # Если заказ успешно обновлен, выполните необходимые действия
      # например, отправка данных в Shopify или обновление статуса заказа
      redirect_to @order, notice: 'Заказ успешно обновлен.'
    else
      render :edit
    end
  end


  def cancel
    @order = Order.find(params[:id])
    # Логика для отмены заказа с использованием Shopify API
    # Например, отправка запроса на отмену заказа в Shopify
    # и обновление соответствующего статуса в базе данных
    if @order.cancel
      # Если заказ успешно отменен, выполните необходимые действия
      redirect_to @order, notice: 'Заказ успешно отменен.'
    else
      redirect_to @order, alert: 'Ошибка при отмене заказа.'
    end
  end


  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_path, notice: 'Заказ успешно удален.'
  end

  private

  # Метод для разрешения параметров заказа, которые можно передать через запрос
  def order_params
    params.require(:order).permit(:shopify_id, :name, :total_price)
  end
end
