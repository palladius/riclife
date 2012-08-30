class AddWorkVenueIdToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :work_venue_id, :integer
    rename_column :people, :l, :location
    rename_column :people, :o, :organisation
  end

  def self.down
    rename_column :people, :organisation, :o
    rename_column :people, :location, :l
    remove_column :people, :work_venue_id
  end
end
