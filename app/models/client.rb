class Client < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :assignments, through: :contacts
  validates :company, :phone, :email, :account_manager, presence: true
end
