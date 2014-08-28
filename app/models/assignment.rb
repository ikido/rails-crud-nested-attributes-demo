# encoding: UTF-8

class Assignment < ActiveRecord::Base

  AGREEMENT_TYPES = [ 'Retained', 'Contingent' ]
  AGREEMENT_CURRENCIES = [ '$' , '£' ]
  AGREEMENT_RATE_TYPES = [ '%', 'Flat' ]

  belongs_to :contact
  has_one :client, through: :contact

  delegate :name, :email, :phone, to: :contact, prefix: true
  delegate :company, to: :client, prefix: true

  validates :title, :potential_fee, :agreement_type, :agreement_currency,
            :agreement_rate_type, presence: true

  validates :agreement_type, inclusion: { in: AGREEMENT_TYPES }
  validates :agreement_currency, inclusion: { in: AGREEMENT_CURRENCIES }
  validates :agreement_rate_type, inclusion: { in: AGREEMENT_RATE_TYPES }
end
