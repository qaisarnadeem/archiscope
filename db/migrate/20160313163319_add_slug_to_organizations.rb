class AddSlugToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :slug, :string ,index: true
  end
end
