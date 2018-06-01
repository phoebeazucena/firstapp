require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { User.create!(email: "janesmith@gmail.com", password: "test123") }
  let(:alternate_user) { User.create!(email: "marysmith@gmail.com", password: "test234") }

  describe 'GET #show' do
    context 'when a user is logged in' do
      before do
        sign_in user
      end

      it 'loads correct user details' do
        get :show, params: { id: user.id }
        expect(response).to be_ok
        expect(assigns(:user)).to eq user
      end
      
      it 'can only access correct user show page'  do
        get :show, params: { id: alternate_user.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end

    end

    context 'when a user is not logged in' do
      it 'redirects to login' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end
end
