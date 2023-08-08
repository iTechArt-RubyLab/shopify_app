require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order1) { Order.create }
  let(:order2) { Order.create }

  describe 'GET #index' do
    it 'assigns all orders to @orders' do
      get :index
      expect(assigns(:orders)).to eq([order1, order2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:order) { Order.create }

    it 'assigns the requested order to @order' do
      get :show, params: { id: order.id }
      expect(assigns(:order)).to eq(order)
    end

    it 'renders the show template' do
      get :show, params: { id: order.id }
      expect(response).to render_template('show')
    end
  end
end
