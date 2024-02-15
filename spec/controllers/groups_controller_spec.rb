require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @groups' do
      group1 = user.groups.create(name: 'Group 1', icon: 'icon')
      group2 = user.groups.create(name: 'Group 2', icon: 'icon')

      get :index

      expect(assigns(:groups)).to eq([group1, group2])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'assigns a new group to @group' do
      get :new

      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new group' do
        group_params = { group: { name: 'Group 1', icon: 'icon' } }

        expect do
          post :create, params: group_params
        end.to change(Group, :count).by(1)
      end

      it 'redirects to groups index' do
        group_params = { group: { name: 'Group 1', icon: 'icon' } }

        post :create, params: group_params

        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq('group was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new group' do
        group_params = { group: { name: nil, icon: nil } }

        expect do
          post :create, params: group_params
        end.not_to change(Group, :count)
      end

      it 'renders the new template' do
        group_params = { group: { name: nil, icon: nil } }

        post :create, params: group_params

        expect(response).to render_template('new')
      end
    end
  end
end
