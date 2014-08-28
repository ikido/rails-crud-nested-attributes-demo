class WorkflowsController < ApplicationController
  before_action :set_assignment

  def new
    @assignment.workflow_phases.build(Assignment::DEFAULT_WORKFLOW)
  end

  def edit
  end

  def update
    if @assignment.update(workflow_params)
      if @assignment.current_workflow_stage.blank?
        @assignment.current_workflow_stage = @assignment.active_workflow_stages.first
        @assignment.save
      end

      redirect_to assignment_path(@assignment), notice: 'Workflow was successfully saved.'
    else
      render :edit
    end
  end

  def show
    @workflow_stages = @assignment.active_workflow_stages
  end

  def complete_current_stage
  end

  def cancel_current_stage
  end

  private

  def workflow_params
    params.require(:assignment).permit(
      workflow_phases_attributes: [
        :name, :order, :id, workflow_stages_attributes: [
          :id, :name, :order, :active
        ]
      ]
    )
  end

  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end

end