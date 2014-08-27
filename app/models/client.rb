class Client < ActiveRecord::Base
  validates :company, :phone, :email, :account_manager, presence: true
end
