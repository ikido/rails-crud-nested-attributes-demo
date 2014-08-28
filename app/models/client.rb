class Client < ActiveRecord::Base
  has_many :contacts
  has_many :assignments, through: :contacts
  validates :company, :phone, :email, :account_manager, presence: true
end
