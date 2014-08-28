class AddCurrentWorkflowStageIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :current_workflow_stage_id, :integer
  end
end
