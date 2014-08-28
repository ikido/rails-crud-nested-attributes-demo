class WorkflowStage < ActiveRecord::Base
  belongs_to :workflow_phase
  has_one :assignment, through: :workflow_phase
  validates :name, :order, presence: true

  def self.active
    self.where(active: true).ordered
  end

  def self.ordered
    includes(:workflow_phase)
    .order('workflow_phases.order ASC, workflow_stages.order ASC')
  end

  def self.actionable
    active.where(self.arel_table[:state].not_eq_all(['completed', 'cancelled', 'skipped']))
  end

  state_machine :state, :initial => :new do

    event :mark_cancelled do
      transition any => :cancelled
    end

    event :mark_completed do
      transition any => :completed
    end

    event :mark_skipped do
      transition any => :skipped
    end

  end

  def disabled?
    (self.assignment and self.assignment.current_workflow_stage == self) or cancelled? or completed? or skipped?
  end
end
