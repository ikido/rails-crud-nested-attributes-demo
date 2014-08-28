class CreateWorkflowPhases < ActiveRecord::Migration
  def change
    create_table :workflow_phases do |t|
      t.integer :assignment_id
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
