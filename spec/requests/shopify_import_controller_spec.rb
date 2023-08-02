require 'rails_helper'

RSpec.describe ShopifyImportController, type: :controller do
  describe '#import' do
    context 'when import is successful' do
      before do
        allow_any_instance_of(ImportProducts).to receive(:call)
        allow_any_instance_of(ImportCustomers).to receive(:call)
      end

      it 'renders plain text with success message' do
        get :import

        expect(response).to have_http_status(:found)
        expect(ImportProducts).to have_received(:new).with(assigns(:session))
        expect(ImportCustomers).to have_received(:new).with(assigns(:session))
      end
    end

    context 'when import raises an error' do
      before do
        allow_any_instance_of(ImportProducts).to receive(:call).and_raise(StandardError, 'Some error message')
        allow_any_instance_of(ImportCustomers).to receive(:call)
      end

      it 'renders plain text with error message' do
        get :import

        expect(response).to have_http_status(:found)
        expect(ImportProducts).to have_received(:new).with(assigns(:session))
        expect(ImportCustomers).to have_received(:new).with(assigns(:session))
      end
    end
  end
end
