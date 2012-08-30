class AddStuffToInetorgpeople < ActiveRecord::Migration
  def self.up
    add_column :inetorgpeople, :photo_name, :string  
    add_column :inetorgpeople, :mail, :string  
    add_column :inetorgpeople, :published, :boolean
    add_column :inetorgpeople, :relevance, :integer
  end

  def self.down
    remove_column :inetorgpeople, :published  
    remove_column :inetorgpeople, :photo_name  
    remove_column :inetorgpeople, :mail
    remove_column :inetorgpeople, :relevance
  end
end
