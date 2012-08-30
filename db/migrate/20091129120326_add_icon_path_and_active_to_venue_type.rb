class AddIconPathAndActiveToVenueType < ActiveRecord::Migration
  def self.up
    #add_column :venue_types, :active, :boolean,      :default => true
    add_column :venue_types, :icon_path, :stringra
  end

  def self.down
    remove_column :venue_types, :icon_path
    #remove_column :venue_types, :active
  end
end
