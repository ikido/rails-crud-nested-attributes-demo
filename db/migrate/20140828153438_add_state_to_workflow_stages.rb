class AddStateToWorkflowStages < ActiveRecord::Migration
  def change
    add_column :workflow_stages, :state, :string
  end
end
