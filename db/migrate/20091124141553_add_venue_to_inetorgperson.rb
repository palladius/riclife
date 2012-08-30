class AddVenueToInetorgperson < ActiveRecord::Migration
  def self.up
    add_column :inetorgpeople, :venue_id, :integer
  end

  def self.down
    remove_column :inetorgpeople, :venue_id
  end
end
