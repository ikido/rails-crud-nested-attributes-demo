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
        @assignment.current_workflow_stage = @assignment.next_actionable_workflow_stage
        @assignment.save
      end

      redirect_to assignment_workflow_path(@assignment), notice: 'Workflow was successfully saved.'
    else
      render :edit
    end
  end

  def show
    @workflow_stages = @assignment.active_workflow_stages
  end

  def complete_current_stage
    @assignment.current_workflow_stage.mark_completed!
    @assignment.switch_to_next_active_stage
    redirect_to assignment_workflow_path(@assignment), notice: 'Current stage marked as completed'
  end

  def cancel_current_stage
    @assignment.current_workflow_stage.mark_cancelled!
    @assignment.switch_to_next_active_stage
    redirect_to assignment_workflow_path(@assignment), notice: 'Current stage marked as cancelled'
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