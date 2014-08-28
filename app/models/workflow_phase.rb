class WorkflowPhase < ActiveRecord::Base
  belongs_to :assignment
  has_many :workflow_stages, dependent: :destroy

  accepts_nested_attributes_for :workflow_stages
  validates :name, :order, presence: true
end
