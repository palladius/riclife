class AddTagsToVenueType < ActiveRecord::Migration
  def self.up
    add_column :venue_types, :tags, :string
    add_column :venues, :tags, :string
    add_column :venues, :vote, :integer, :defult => 60
  end

  def self.down
    remove_column :venues, :vote
    remove_column :venues, :tags
    remove_column :venue_types, :tags
  end
end
