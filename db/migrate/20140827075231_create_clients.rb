class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company
      t.string :email
      t.string :phone
      t.string :account_manager

      t.timestamps
    end
  end
end
