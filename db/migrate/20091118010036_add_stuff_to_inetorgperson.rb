class AddStuffToInetorgperson < ActiveRecord::Migration
  def self.up
    add_column :inetorgpeople, :male, :boolean
    add_column :inetorgpeople, :birthday, :date
  end

  def self.down
    remove_column :inetorgpeople, :birthday
    remove_column :inetorgpeople, :male
  end
end
