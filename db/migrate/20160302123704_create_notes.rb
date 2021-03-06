class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
