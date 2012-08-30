class AddFeedToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :feed, :string
  end

  def self.down
    remove_column :people, :feed
  end
end
