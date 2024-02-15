class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :expense_groups
  has_many :groups, through: :expense_groups
end
