class RenameInetorgPersonIdOnGroups < ActiveRecord::Migration
  def self.up
    rename_column :groups, :inetorgperson_id, :person_id 
    rename_column :identities, :inetorgperson_id, :person_id 
    rename_column :projects, :inetorgperson_id, :person_id 
  end

  def self.down
    rename_column :projects, :person_id, :inetorgperson_id
    rename_column :identities, :person_id, :inetorgperson_id
    rename_column :groups, :person_id, :inetorgperson_id
  end
end
