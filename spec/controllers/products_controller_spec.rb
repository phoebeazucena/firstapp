require 'rails_helper'

describe ProductsController, type: :controller do

  before do
    @product = FactoryBot.create(:product)
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    # product_params: = { name: soap, descrip}
  end

  describe 'GET #index' do #------------------INDEX
    context 'when user loads index page' do
      it 'renders index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  describe 'GET #show' do #------------------SHOW
    context 'when a user is logged in' do
      before do
        sign_in @user
      end

      it 'loads the correct product' do
        get :show, params: { id: @product.id }
        expect(response).to be_ok
        expect(assigns(:product)).to eq @product
      end
    end
  end

  describe 'GET #new' do #------------------NEW
    before do
      sign_in @user
      context 'when a user is not admin' do
        it 'does not allow user to access new product' do
          get :new, params: { id: @product.id }
          expect(response).to redirect_to main_app.root_url
        end
      end
    end

    before do
      sign_in @admin
      context 'when admin is signed in' do
        it 'allows admin to access new product' do
          get :new, params: { id: @product.id }
          expect(response).to be_ok
        end
      end
    end
  end

  describe 'GET #edit' do #------------------EDIT
    before do
      sign_in @user
      context 'when a user is not admin' do
        it 'does not allow user to edit product' do
          get :edit, params: { id: @product.id }
          expect(response).to redirect_to main_app.root_url
        end
      end
    end

    before do
      sign_in @admin
      context 'when admin is signed in' do
        it 'allows admin to edit product' do
          get :edit, params: { id: @product.id }
          expect(response).to be_ok
        end
      end
    end
  end

  describe 'POST #create' do #------------------CREATE
    before do
      sign_in @user
      context 'when a user is not admin' do
        it 'does not allow user to create new product' do
          post :create, params: { id: @product.id }
          expect(response).to redirect_to main_app.root_url
        end
      end
    end

    before do
      sign_in @admin
      context 'when admin is signed in' do
        it 'allows admin to create new product' do
          post :create, params: { id: @product.id }
          expect(response).to be_ok
        end

        it 'will not create product without all required info' do
          post :create, product_params: { name: "soap" }
          expect(response).to have_http_status(422)
        end

        it 'will create product with all required info' do
          post :create, product_params: { name: "soap", descrition: "clean",
            image_url: "soap-2333412_960_720.jpg", colour: "pink", price: 5.00 }
          expect(response).to be_ok
        end
      end
    end
  end

  describe 'PUT #update' do #------------------UPDATE
    before do
      sign_in @user
      context 'when a user is not admin' do
        it 'does not allow user to update product' do
          put :update, params: { id: @product.id }
          expect(response).to redirect_to main_app.root_url
        end
      end
    end

    before do
      sign_in @admin
      context 'when admin is signed in' do
        it 'allows admin to update product' do
          put :update, params: { id: @product.id }
          expect(response).to be_ok
        end
      end
    end
  end

  describe 'DELETE #destroy' do #------------------DESTROY
    before do
      sign_in @user
      context 'when a user is not admin' do
        it 'does not allow user to destroy product' do
          delete :destroy, params: { id: @product.id }
          expect(response).to redirect_to main_app.root_url
        end
      end
    end

    before do
      sign_in @admin
      context 'when admin is signed in' do
        it 'allows admin to destroy product' do
          delete :destroy, params: { id: @product.id }
          expect(response).to be_ok
        end
      end
    end
  end

end
