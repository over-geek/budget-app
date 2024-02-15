require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'when user is signed in' do
      it 'redirects to groups path' do
        get :index

        expect(response).to redirect_to(groups_path)
      end
    end

    context 'when user is not signed in' do
      before do
        sign_out user
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template('index')
      end
    end
  end
end
