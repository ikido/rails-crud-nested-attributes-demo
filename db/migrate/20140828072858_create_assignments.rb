class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :contact_id
      t.string :title
      t.string :potential_fee
      t.string :agreement_type
      t.string :agreement_currency
      t.string :agreement_rate_type

      t.timestamps
    end
  end
end
