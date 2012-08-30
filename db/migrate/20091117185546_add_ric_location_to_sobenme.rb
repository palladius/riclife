class AddRicLocationToSobenme < ActiveRecord::Migration
    def self.up
     add_column :inetorgpeople, :riclocation_id, :integer
  end

  def self.down
    remove_column :inetorgpeople, :riclocation_id
  end
  
end