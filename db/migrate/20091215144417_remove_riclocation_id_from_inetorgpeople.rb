class RemoveRiclocationIdFromInetorgpeople < ActiveRecord::Migration
  def self.up
		remove_column :inetorgpeople, :riclocation_id  
  end

  def self.down
		   add_column :inetorgpeople, :riclocation_id, :integer  
	end
end
