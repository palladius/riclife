class AddActiveToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :active, :boolean,            :default => true
    add_column :groups, :inetorgperson_id, :integer
  end

  def self.down
    remove_column :groups, :inetorgperson_id
    remove_column :groups, :active
  end
end
