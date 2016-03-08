class AddReferredByToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :referred_by, :string
  end
end
