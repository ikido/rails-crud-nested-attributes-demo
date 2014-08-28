class WorkflowStage < ActiveRecord::Base
  belongs_to :workflow_phase
  has_one :assignment, through: :workflow_phase
  validates :name, :order, presence: true

  def self.active
    self.where(active: true)
      .includes(:workflow_phase)
      .order('workflow_phases.order ASC, workflow_stages.order ASC')
  end

  def self.actionable
    active.where(self.arel_table[:state].not_eq_all(['completed', 'cancelled']))
  end

  def mark_completed
    self.state = 'completed'
    self.save
  end

  def mark_cancelled
    self.state = 'cancelled'
    save
  end

  def completed?
    state == 'completed'
  end

  def cancelled?
    state == 'cancelled'
  end

  def disabled?
    (self.assignment and self.assignment.current_workflow_stage == self) or cancelled? or completed?
  end
end
