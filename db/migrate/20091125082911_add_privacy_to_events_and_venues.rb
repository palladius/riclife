class AddPrivacyToEventsAndVenues < ActiveRecord::Migration
  def self.up
    add_column :events, :private, :boolean, :default => false
    add_column :venues, :private, :boolean, :default => false
  end

  def self.down
    remove_column :venues, :private
    remove_column :events, :private
  end
end
