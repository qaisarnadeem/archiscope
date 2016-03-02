class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :organization_type_id
      t.string :address
      t.text :about
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
