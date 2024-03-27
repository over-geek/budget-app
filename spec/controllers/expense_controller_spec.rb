require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }
  let(:group) { Group.create(name: 'Group 1', icon: 'icon', user:) }

  before do
    sign_in user
  end
  describe 'GET #index' do
    it 'assigns @expenses' do
      expense1 = Expense.create(name: 'Expense 1', amount: 10, user:, group_id: group.id)
      ExpenseGroup.create(group:, expense: expense1)

      get :index, params: { group_id: group.id }

      expect(assigns(:expenses)).to eq([expense1])
    end

    it 'renders the index template' do
      get :index, params: { group_id: group.id }

      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'assigns a new expense to @expense' do
      get :new, params: { group_id: group.id }

      expect(assigns(:expense)).to be_a_new(Expense)
    end

    it 'renders the new template' do
      get :new, params: { group_id: group.id }

      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new expense' do
        expense_params = { expense: { name: 'Sample Expense', amount: 10 } }

        expect do
          post :create, params: expense_params.merge(group_id: group.id)
        end.to change(Expense, :count).by(1)
      end

      it 'creates a new expense group' do
        expense_params = { expense: { name: 'Sample Expense', amount: 10 } }

        expect do
          post :create, params: expense_params.merge(group_id: group.id)
        end.to change(ExpenseGroup, :count).by(1)
      end

      it 'redirects to group expenses index' do
        expense_params = { expense: { name: 'Sample Expense', amount: 10 } }

        post :create, params: expense_params.merge(group_id: group.id)

        expect(response).to redirect_to(group_expenses_path(group))
        expect(flash[:notice]).to eq('Expense was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new expense' do
        expense_params = { expense: { name: nil, amount: nil } }

        expect do
          post :create, params: expense_params.merge(group_id: group.id)
        end.not_to change(Expense, :count)
      end

      it 'renders the new template' do
        expense_params = { expense: { name: nil, amount: nil } }

        post :create, params: expense_params.merge(group_id: group.id)

        expect(response).to render_template('new')
      end
    end
  end
end
