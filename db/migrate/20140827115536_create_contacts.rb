class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :client_id
      t.string :name
      t.string :job_title
      t.string :phone
      t.string :email
      t.string :account_manager

      t.timestamps
    end
  end
end
