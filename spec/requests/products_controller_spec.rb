require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all products to @products' do
      product1 = create(:product)
      product2 = create(:product)

      get :index

      expect(assigns(:products)).to match_array([product1, product2])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested product to @product' do
      product = create(:product)

      get :show, params: { id: product.id }

      expect(assigns(:product)).to eq(product)
    end

    it 'renders the show template' do
      product = create(:product)

      get :show, params: { id: product.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new product to @product' do
      get :new

      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect do
          post :create, params: { product: attributes_for(:product) }
        end.to change(Product, :count).by(1)
      end

      it 'redirects to the products index' do
        post :create, params: { product: attributes_for(:product) }

        expect(response).to redirect_to(products_path)
      end

      it 'sets the flash notice' do
        post :create, params: { product: attributes_for(:product) }

        expect(flash[:notice]).to eq('Product was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new product' do
        expect do
          post :create, params: { product: attributes_for(:product, title: '') }
        end.not_to change(Product, :count)
      end

      it 'renders the new template' do
        post :create, params: { product: attributes_for(:product, title: '') }

        expect(response).to render_template(:new)
      end

      it 'sets the status to unprocessable_entity' do
        post :create, params: { product: attributes_for(:product, title: '') }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested product to @product' do
      product = create(:product)

      get :edit, params: { id: product.id }

      expect(assigns(:product)).to eq(product)
    end

    it 'renders the edit template' do
      product = create(:product)

      get :edit, params: { id: product.id }

      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:product) { create(:product) }

      it 'updates the product' do
        patch :update, params: { id: product.id, product: { title: 'New Title' } }

        product.reload

        expect(product.title).to eq('New Title')
      end

      it 'redirects to the product show page' do
        patch :update, params: { id: product.id, product: { title: 'New Title' } }

        expect(response).to redirect_to(product)
      end

      it 'sets the flash notice' do
        patch :update, params: { id: product.id, product: { title: 'New  Title' } }

        expect(flash[:notice]).to eq('Product was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      let(:product) { create(:product) }

      it 'does not update the product' do
        patch :update, params: { id: product.id, product: { title: '' } }

        product.reload

        expect(product.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: product.id, product: { title: '' } }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product) { create(:product) }

    it 'destroys the product' do
      expect do
        delete :destroy, params: { id: product.id }
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the products index' do
      delete :destroy, params: { id: product.id }

      expect(response).to redirect_to(products_path)
    end

    it 'sets the flash notice' do
      delete :destroy, params: { id: product.id }

      expect(flash[:notice]).to eq('The product was successfully destroyed.')
    end
  end
end
