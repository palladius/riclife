class AddTagsToFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :tags, :string, :default => 'friend'
  end

  def self.down
    remove_column :friendships, :tags
  end
end
