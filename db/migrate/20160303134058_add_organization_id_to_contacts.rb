class AddOrganizationIdToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :organization, index: true, foreign_key: true
  end
end
