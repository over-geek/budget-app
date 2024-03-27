require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.new(name: 'Ken', email: 'test@test.com', password: '123456') }
  let(:expense) { Expense.new(name: 'Test Expense', amount: 100.0, user:) }
  it 'is valid with valid attributes' do
    expect(expense).to be_valid
  end

  it 'is not valid without a name' do
    expense.name = nil
    expect(expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    expense.amount = nil
    expect(expense).to_not be_valid
  end

  it 'has many expense groups' do
    expect(expense).to respond_to(:expense_groups)
  end

  it 'has many groups through expense groups' do
    expect(expense).to respond_to(:expense_groups)
  end
end
