class Client < ActiveRecord::Base
  has_many :contacts
  validates :company, :phone, :email, :account_manager, presence: true
end
