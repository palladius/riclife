class AddStarredToInetorgperson < ActiveRecord::Migration
  def self.up
     add_column :inetorgpeople, :starred, :boolean
  end

  def self.down
    remove_column :inetorgpeople, :nickname
  end
end
