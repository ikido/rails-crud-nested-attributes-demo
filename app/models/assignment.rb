# encoding: UTF-8

class Assignment < ActiveRecord::Base

  AGREEMENT_TYPES = [ 'Retained', 'Contingent' ]
  AGREEMENT_CURRENCIES = [ '$' , '£' ]
  AGREEMENT_RATE_TYPES = [ '%', 'Flat' ]

  belongs_to :contact
  has_one :client, through: :contact
  has_many :workflow_phases, dependent: :destroy
  has_many :workflow_stages, through: :workflow_phases
  belongs_to :current_workflow_stage, class_name: 'WorkflowStage'

  accepts_nested_attributes_for :workflow_phases

  delegate :name, :email, :phone, to: :contact, prefix: true
  delegate :company, to: :client, prefix: true

  validates :title, :potential_fee, :agreement_type, :agreement_currency,
            :agreement_rate_type, presence: true

  validates :agreement_type, inclusion: { in: AGREEMENT_TYPES }
  validates :agreement_currency, inclusion: { in: AGREEMENT_CURRENCIES }
  validates :agreement_rate_type, inclusion: { in: AGREEMENT_RATE_TYPES }

  DEFAULT_WORKFLOW = [
    {
      name: 'Needs Analysis',
      order: 1,
      workflow_stages_attributes: [
        { name: 'Briefing Meeting', order: 1, active: true },
        { name: 'Agree Terms', order: 2, active: true }
      ]
    },
    {
      name: 'Research',
      order: 2,
      workflow_stages_attributes: [
        { name: 'Research And Mining', order: 1, active: true },
        { name: 'Candidate Generation', order: 2, active: true }
      ]
    },
    {
      name: 'Interview Process',
      order: 3,
      workflow_stages_attributes: [
        { name: 'Present Candidate Shortlist', order: 1, active: true },
        { name: 'Interview Stage 1', order: 2, active: true }
      ]
    },
    {
      name: 'Offer Management',
      order: 4,
      workflow_stages_attributes: [
        { name: 'Debrief with client and candidates', order: 1, active: true },
        { name: 'Offer management', order: 2, active: true }
      ]
    }
  ]

  def active_workflow_stages
    workflow_stages.active
  end

  def next_actionable_workflow_stage
    workflow_stages.actionable.first
  end

  def has_workflow_stages?
    !active_workflow_stages.blank?
  end

  def has_actionable_stages?
    !workflow_stages.actionable.blank?
  end

  def current_stage
    current_workflow_stage.blank? ? 'None' : current_workflow_stage.name
  end

  def switch_to_next_active_stage
    active_stages = active_workflow_stages
    current_index = active_stages.find_index(current_workflow_stage)
    self.current_workflow_stage = active_stages[current_index+1]
    self.save

    # Mark unchecked stages that are behind current as skipped
    all_stages = workflow_stages.ordered
    new_current_stage_index = all_stages.find_index(self.current_workflow_stage)
    all_stages.each_with_index do |stage, index|
      if !stage.active? and (new_current_stage_index.blank? or index < new_current_stage_index)
        stage.mark_skipped
      end
    end

  end

end
