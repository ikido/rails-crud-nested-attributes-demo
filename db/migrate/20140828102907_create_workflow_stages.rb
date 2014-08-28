class CreateWorkflowStages < ActiveRecord::Migration
  def change
    create_table :workflow_stages do |t|
      t.integer :workflow_phase_id
      t.string :name
      t.boolean :active
      t.integer :order

      t.timestamps
    end
  end
end
