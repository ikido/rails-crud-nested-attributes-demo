class WorkflowStage < ActiveRecord::Base
  belongs_to :workflow_phase
  validates :name, :order, presence: true

  def self.active
    self.where(active: true)
      .includes(:workflow_phase)
      .order('workflow_phases.order ASC, workflow_stages.order ASC')
  end

  def is_current_stage_for?(assignment)
    assignment.current_workflow_stage == self
  end
end
