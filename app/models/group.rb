class Group < ApplicationRecord
  belongs_to :user

  has_many :expense_groups, dependent: :destroy
  has_many :expenses, through: :expense_groups, dependent: :destroy
end
