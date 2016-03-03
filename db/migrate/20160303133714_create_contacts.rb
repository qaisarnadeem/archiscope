class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :status_id
      t.string :position

      t.timestamps null: false
    end
  end
end
